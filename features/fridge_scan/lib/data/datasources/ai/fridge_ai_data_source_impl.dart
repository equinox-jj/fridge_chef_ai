import 'dart:convert';
import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/logger/app_logger.dart';
// Firebase AI also exports a `ServerException`; hide it so the core domain
// exception is the one in scope here.
import 'package:dependencies/firebase/firebase_ai.dart' hide ServerException;

import '../../models/ingredient_model.dart';
import 'fridge_ai_data_source.dart';

class FridgeAiDataSourceImpl implements FridgeAiDataSource {
  FridgeAiDataSourceImpl(this._logger, {GenerativeModel? model})
    : _model =
          model ??
          FirebaseAI.googleAI().generativeModel(
            model: _modelName,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
              // Enforce the output shape so every ingredient always carries all
              // four fields. Without this the model omits `quantity`/`unit` when
              // unsure, which deserialises to null — with it they are required,
              // so the model emits "" instead of dropping the key.
              responseSchema: _responseSchema,
            ),
          );

  final AppLogger _logger;
  final GenerativeModel _model;

  static const String _modelName = 'gemini-3.5-flash';

  /// Allowed ingredient categories the model must choose from.
  static const List<String> _categories = <String>[
    'produce',
    'dairy',
    'meat',
    'seafood',
    'beverage',
    'condiment',
    'grain',
    'frozen',
    'other',
  ];

  /// Category used when the model returns one outside [_categories]; it is the
  /// safe catch-all the DB check constraint always permits.
  static const String _fallbackCategory = 'other';

  /// Structured-output contract: an array of ingredient objects. Every property
  /// is required (none listed in `optionalProperties`), so `quantity`/`unit` are
  /// always present in the response — empty string when unknown, never null.
  static final Schema _responseSchema = Schema.array(
    items: Schema.object(
      properties: <String, Schema>{
        'name': Schema.string(
          description: 'Ingredient name, lowercase singular (e.g. "tomato").',
        ),
        'quantity': Schema.string(
          description:
              'Best-effort amount as a string (e.g. "2", "500"); '
              'use "" only when it truly cannot be told.',
        ),
        'unit': Schema.string(
          description:
              'Unit for the quantity ("pcs" for countable items, else '
              '"g", "ml", etc.); use "" when unknown.',
        ),
        'category': Schema.enumString(enumValues: _categories),
      },
    ),
  );

  static const String _prompt = '''
You are a kitchen assistant expert. Look at this photo of the inside of a fridge and
identify every distinct food ingredient you can see.

For each ingredient:
- "name": the ingredient name, lowercase singular (e.g. "tomato").
- "quantity": your best estimate of the amount as a string — count the visible
  items where you can (e.g. "3"); use "" only when you truly cannot tell.
- "unit": the unit for that quantity — "pcs" for countable items, otherwise a
  sensible measure like "g" or "ml"; use "" when unknown.
- "category": the best-fitting category for the ingredient.

If you can see no food, return an empty array.
''';

  @override
  Future<AiAnalysisResult> analyzeImage(Uint8List imageBytes) async {
    _logger.debug(
      'AI ingredient analysis requested ($_modelName, '
      '${imageBytes.lengthInBytes} bytes).',
    );

    final String raw;
    try {
      final GenerateContentResponse response = await _model.generateContent(
        <Content>[
          Content.multi(<Part>[
            TextPart(_prompt),
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
      throw ServerException('Failed to analyze the image: $e');
    }

    // Log the raw payload before parsing so a malformed response is still
    // captured for debugging (mirrors the persisted `raw_ai_response`).
    _logger.info('AI ingredient analysis response:\n$raw');

    final List<IngredientModel> ingredients = _parseIngredients(raw);
    _logger.debug('Parsed ${ingredients.length} ingredient(s) from AI response.');

    return AiAnalysisResult(
      ingredients: ingredients,
      rawResponse: raw,
    );
  }

  /// Parses the model's JSON array response into [IngredientModel]s.
  List<IngredientModel> _parseIngredients(String raw) {
    if (raw.trim().isEmpty) {
      throw const ServerException(
        'The AI returned an empty response. Please try again.',
      );
    }
    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw const FormatException('Expected a JSON array of ingredients.');
      }
      return decoded.whereType<Map<String, dynamic>>().map(IngredientModel.fromJson).map(_withSafeCategory).toList();
    } on FormatException catch (e) {
      throw ServerException('Could not read ingredients from the image: $e');
    }
  }

  /// Coerces any category outside [_categories] (or a null/empty one) to
  /// [_fallbackCategory], so a value the model invents can never violate the
  /// `ingredients_category_check` constraint on insert.
  IngredientModel _withSafeCategory(IngredientModel ingredient) {
    if (_categories.contains(ingredient.category)) {
      return ingredient;
    }
    return ingredient.copyWith(category: _fallbackCategory);
  }
}
