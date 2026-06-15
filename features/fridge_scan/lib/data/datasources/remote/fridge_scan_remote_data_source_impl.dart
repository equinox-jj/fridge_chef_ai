import 'dart:convert';
import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/gemini_ai/gemini_constants.dart';
import 'package:core/constants/gemini_ai/ingredient_categories.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/firebase/firebase_ai.dart' hide ServerException;
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import '../../models/ingredient_model.dart';
import '../../models/scan_model.dart';
import '../../schema/food_schema.dart';
import 'fridge_scan_remote_data_source.dart';

class FridgeScanRemoteDataSourceImpl implements FridgeScanRemoteDataSource {
  FridgeScanRemoteDataSourceImpl({
    required this._supabaseService,
    required this._logger,
  });

  SupabaseClient get _client => _supabaseService.client;

  final SupabaseService _supabaseService;
  final AppLogger _logger;

  final GenerativeModel _model = FirebaseAI.googleAI().generativeModel(
    model: GeminiConstants.geminiModel,
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
      // Enforce the output shape so every ingredient always carries all
      // four fields. Without this the model omits `quantity`/`unit` when
      // unsure, which deserialises to null — with it they are required,
      // so the model emits "" instead of dropping the key.
      responseSchema: FoodSchema.responseSchema,
    ),
  );

  @override
  Future<String> uploadImage({required Uint8List bytes}) {
    return _supabaseService.safeCall(() async {
      final String userId = _requireUserId();
      final String path =
          '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _client.storage
          .from(SupabaseTable.fridgeScansTable)
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );
      return _client.storage
          .from(SupabaseTable.fridgeScansTable)
          .createSignedUrl(
            path,
            GeminiConstants.signedUrlTtl,
          );
    });
  }

  @override
  Future<ScanModel> insertScan({
    required String imageUrl,
    required String rawAiResponse,
  }) {
    return _supabaseService.safeCall(() async {
      final Map<String, dynamic> inserted = await _client
          .from(SupabaseTable.fridgeScansTable)
          .insert(<String, dynamic>{
            'user_id': _requireUserId(),
            'image_url': imageUrl,
            'raw_ai_response': rawAiResponse,
          })
          .select()
          .single();
      return ScanModel.fromJson(inserted);
    });
  }

  @override
  Future<List<IngredientModel>> insertIngredients({
    required String scanId,
    required List<IngredientModel> items,
  }) {
    return _supabaseService.safeCall(() async {
      if (items.isEmpty) {
        return <IngredientModel>[];
      }
      final List<Map<String, dynamic>> rows = items
          .map(
            (IngredientModel item) => <String, dynamic>{
              'scan_id': scanId,
              'name': item.name,
              'quantity': item.quantity,
              'unit': item.unit,
              'category': item.category,
            },
          )
          .toList();
      final List<Map<String, dynamic>> inserted = await _client
          .from(SupabaseTable.ingredientsTable)
          .insert(rows)
          .select();
      return inserted.map(IngredientModel.fromJson).toList();
    });
  }

  @override
  Future<List<ScanWithIngredients>> getRecentScans({required int limit}) {
    return _supabaseService.safeCall(() async {
      // One round-trip: each scan row embeds its ingredients via the FK join,
      // so we avoid an N+1 query per scan.
      final List<Map<String, dynamic>> rows = await _client
          .from(SupabaseTable.fridgeScansTable)
          .select('*, ${SupabaseTable.ingredientsTable}(*)')
          .eq('user_id', _requireUserId())
          .order('scanned_at', ascending: false)
          .limit(limit);

      return rows.map((Map<String, dynamic> row) {
        final List<dynamic> rawIngredients =
            row[SupabaseTable.ingredientsTable] as List<dynamic>? ??
            <dynamic>[];
        return (
          scan: ScanModel.fromJson(row),
          ingredients: rawIngredients
              .whereType<Map<String, dynamic>>()
              .map(IngredientModel.fromJson)
              .toList(),
        );
      }).toList();
    });
  }

  @override
  Future<AiAnalysisResult> analyzeImage({required Uint8List imageBytes}) async {
    _logger.debug(
      'AI ingredient analysis requested (${GeminiConstants.geminiModel}, '
      '${imageBytes.lengthInBytes} bytes).',
    );

    final String raw;
    try {
      final GenerateContentResponse response = await _model.generateContent(
        <Content>[
          Content.multi(<Part>[
            TextPart(
              GeminiConstants.ingredientScanPrompt,
            ),
            InlineDataPart('image/jpeg', imageBytes),
          ]),
        ],
      );
      raw = response.text ?? '';
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      _logger.error(
        'AI ingredient analysis request failed.',
        error: e,
        stackTrace: stackTrace,
      );
      throw const ServerException(
        "We couldn't analyze that photo right now. Please try again.",
      );
    }

    // Log the raw payload before parsing so a malformed response is still
    // captured for debugging (mirrors the persisted `raw_ai_response`).
    _logger.info('AI ingredient analysis response:\n$raw');

    final List<IngredientModel> ingredients = _parseIngredients(raw);
    _logger.debug(
      'Parsed ${ingredients.length} ingredient(s) from AI response.',
    );

    return AiAnalysisResult(
      ingredients: ingredients,
      rawResponse: raw,
    );
  }

  /// Parses the model's JSON response into [IngredientModel]s.
  ///
  /// Throws a [NoFoodDetectedException] when the model reports the photo is not
  /// food, or when no ingredients were detected — so the caller can abort
  /// before persisting anything.
  List<IngredientModel> _parseIngredients(String raw) {
    if (raw.trim().isEmpty) {
      throw const ServerException(
        'The AI returned an empty response. Please try again.',
      );
    }

    final List<IngredientModel> ingredients;
    final bool isFood;
    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Expected a JSON object.');
      }
      isFood = decoded['is_food'] == true;
      final dynamic items = decoded['ingredients'];
      ingredients = items is List
          ? items
                .whereType<Map<String, dynamic>>()
                .map(IngredientModel.fromJson)
                .map(_withSafeCategory)
                .toList()
          : <IngredientModel>[];
    } on FormatException catch (e, stackTrace) {
      _logger.error(
        'Failed to parse AI ingredient response.',
        error: e,
        stackTrace: stackTrace,
      );
      throw const ServerException(
        "We couldn't read the ingredients from that photo. Please try again.",
      );
    }

    if (!isFood || ingredients.isEmpty) {
      throw const NoFoodDetectedException();
    }
    return ingredients;
  }

  /// Coerces any category outside [_categories] (or a null/empty one) to
  /// [_fallbackCategory], so a value the model invents can never violate the
  /// `ingredients_category_check` constraint on insert.
  IngredientModel _withSafeCategory(IngredientModel ingredient) {
    if (IngredientCategories.getDisplayNames().contains(ingredient.category)) {
      return ingredient;
    }

    /// Category used when the model returns one outside
    /// [IngredientCategories.getDisplayNames()]; it is the safe catch-all the
    /// DB check constraint always permits.
    return ingredient.copyWith(
      category: IngredientCategories.other.displayName,
    );
  }

  /// Returns the current user id, or throws when there is no active session.
  String _requireUserId() {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw const InvalidCredentialsException(
        'You must be signed in to scan your fridge.',
      );
    }
    return user.id;
  }
}
