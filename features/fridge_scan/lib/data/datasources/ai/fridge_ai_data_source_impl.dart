import 'dart:convert';
import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/logger/app_logger.dart';
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

  /// Structured-output contract: an object carrying an [is_food] verdict plus
  /// the detected [ingredients]. Every property is required (none listed in
  /// `optionalProperties`), so `quantity`/`unit` are always present — empty
  /// string when unknown, never null.
  static final Schema _responseSchema = Schema.object(
    properties: <String, Schema>{
      'is_food': Schema.boolean(
        description:
            'True only if the photo shows food, ingredients, or the inside of '
            'a fridge. False for anything else (people, rooms, objects, '
            'screenshots, etc.).',
      ),
      'ingredients': Schema.array(
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
      ),
    },
  );

  static const String _prompt = '''
You are a kitchen assistant expert. First decide whether this photo actually
shows food, ingredients, or the inside of a fridge.

If it does NOT (e.g. a person, a room, a random object, a screenshot), set
"is_food" to false and return an empty "ingredients" array. Do not invent
ingredients.

If it does, set "is_food" to true and list every distinct food ingredient you
can see. For each ingredient:
- "name": the ingredient name, lowercase singular (e.g. "tomato").
- "quantity": your best estimate of the amount as a string — count the visible
  items where you can (e.g. "3"); use "" only when you truly cannot tell.
- "unit": the unit for that quantity — "pcs" for countable items, otherwise a
  sensible measure like "g" or "ml"; use "" when unknown.
- "category": the best-fitting category for the ingredient.
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
          ? items.whereType<Map<String, dynamic>>().map(IngredientModel.fromJson).map(_withSafeCategory).toList()
          : <IngredientModel>[];
    } on FormatException catch (e) {
      throw ServerException('Could not read ingredients from the image: $e');
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
    if (_categories.contains(ingredient.category)) {
      return ingredient;
    }
    return ingredient.copyWith(category: _fallbackCategory);
  }
}
