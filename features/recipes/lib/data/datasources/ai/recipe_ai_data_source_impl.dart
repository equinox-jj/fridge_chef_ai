import 'dart:convert';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/logger/app_logger.dart';
import 'package:dependencies/firebase/firebase_ai.dart' hide ServerException;

import '../../models/recipe_model.dart';
import 'recipe_ai_data_source.dart';

class RecipeAiDataSourceImpl implements RecipeAiDataSource {
  RecipeAiDataSourceImpl(this._logger, {GenerativeModel? model})
    : _model =
          model ??
          FirebaseAI.googleAI().generativeModel(
            model: _modelName,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
              // Enforce the output shape so every recipe always carries all its
              // fields (no dropped keys when the model is unsure) — substitutes
              // and step timers in particular must always be present.
              responseSchema: _responseSchema,
            ),
          );

  final AppLogger _logger;
  final GenerativeModel _model;

  // static const String _modelName = 'gemini-3.5-flash';
  static const String _modelName = 'gemini-2.5-flash';

  /// Exactly how many recipes a single generation returns (PRD §4.3.2).
  static const int _recipeCount = 3;

  /// Structured-output contract mirroring the PRD recipe schema. Every property
  /// is required (none optional), so `is_substitute` and `timer_seconds` are
  /// always emitted; `timer_seconds` is `0` for an untimed step rather than
  /// being omitted.
  static final Schema _responseSchema = Schema.object(
    properties: <String, Schema>{
      'recipes': Schema.array(
        items: Schema.object(
          properties: <String, Schema>{
            'title': Schema.string(description: 'Short, appetising recipe name.'),
            'description': Schema.string(description: 'One-sentence description of the dish.'),
            'servings': Schema.integer(description: 'How many people it serves.'),
            'cook_time_minutes': Schema.integer(description: 'Total cook time in minutes.'),
            'ingredients': Schema.array(
              items: Schema.object(
                properties: <String, Schema>{
                  'name': Schema.string(description: 'Ingredient name.'),
                  'quantity': Schema.string(description: 'Amount, e.g. "1", "250"; "" if not applicable.'),
                  'unit': Schema.string(description: 'Unit, e.g. "g", "ml", "cup", "can"; "" if none.'),
                  'is_substitute': Schema.boolean(
                    description: 'True when this ingredient replaces one the user does not have.',
                  ),
                },
              ),
            ),
            'steps': Schema.array(
              items: Schema.object(
                properties: <String, Schema>{
                  'step_number': Schema.integer(description: 'Order of the step, starting at 1.'),
                  'instruction': Schema.string(description: 'What to do in this step.'),
                  'timer_seconds': Schema.integer(
                    description: 'Seconds for a timed step (e.g. "simmer 10 min" = 600); 0 if untimed.',
                  ),
                },
              ),
            ),
          },
        ),
      ),
    },
  );

  @override
  Future<List<RecipeModel>> generateRecipes({
    required List<String> ingredientLines,
    required String mood,
    required String dietaryPreference,
  }) async {
    final String prompt = _buildPrompt(
      ingredientLines: ingredientLines,
      mood: mood,
      dietaryPreference: dietaryPreference,
    );

    _logger.debug(
      'AI recipe generation requested ($_modelName, mood: $mood, '
      'diet: $dietaryPreference, ${ingredientLines.length} ingredient(s)).',
    );

    final String raw;
    try {
      final GenerateContentResponse response = await _model.generateContent(
        <Content>[Content.text(prompt)],
      );
      raw = response.text ?? '';
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      _logger.error(
        'AI recipe generation request failed.',
        error: e,
        stackTrace: stackTrace,
      );
      throw ServerException('Failed to write recipes: $e');
    }

    _logger.info('AI recipe generation response:\n$raw');

    final List<RecipeModel> recipes = _parseRecipes(raw, mood);
    _logger.debug('Parsed ${recipes.length} recipe(s) from AI response.');
    return recipes;
  }

  /// Builds the generation prompt (PRD §11.2). The dietary line is only added
  /// when a real preference is set, so "none" never leaks into the prompt.
  String _buildPrompt({
    required List<String> ingredientLines,
    required String mood,
    required String dietaryPreference,
  }) {
    final String ingredientList = ingredientLines.map((String l) => '- $l').join('\n');
    final bool hasDiet = dietaryPreference.isNotEmpty && dietaryPreference.toLowerCase() != 'none';
    final String dietRule = hasDiet ? 'All recipes must be suitable for a $dietaryPreference diet.\n' : '';

    return '''
You are a creative chef. Given these fridge ingredients:
$ingredientList

Generate exactly $_recipeCount recipes matching the "$mood" mood.
$dietRule
Rules:
- Exactly $_recipeCount recipes.
- Use the provided ingredients plus common pantry items (salt, oil, water, spices).
- Set "timer_seconds" for any timed step; use 0 when the step is not timed.
- Set "is_substitute" to true when an ingredient replaces a missing item.
- "step_number" starts at 1 and increases in order.
''';
  }

  /// Parses the model's JSON into [RecipeModel]s, attaching the requested
  /// [mood] to each (it is a generation input, not part of the response).
  List<RecipeModel> _parseRecipes(String raw, String mood) {
    if (raw.trim().isEmpty) {
      throw const ServerException('The AI returned an empty response. Please try again.');
    }

    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Expected a JSON object.');
      }
      final dynamic items = decoded['recipes'];
      final List<RecipeModel> recipes = items is List
          ? items
                .whereType<Map<String, dynamic>>()
                .map(RecipeModel.fromJson)
                .map((RecipeModel r) => r.copyWith(mood: mood))
                .toList()
          : <RecipeModel>[];

      if (recipes.isEmpty) {
        throw const ServerException('No recipes could be written from those ingredients. Please try again.');
      }
      return recipes;
    } on FormatException catch (e) {
      throw ServerException('Could not read the recipes from the AI response: $e');
    }
  }
}
