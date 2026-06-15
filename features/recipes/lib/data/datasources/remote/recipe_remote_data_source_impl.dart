import 'dart:convert';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/gemini_ai/gemini_constants.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/firebase/firebase_ai.dart' hide ServerException;
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import '../../models/recipe_ingredient_model.dart';
import '../../models/recipe_model.dart';
import '../../models/recipe_step_model.dart';
import '../../models/saved_recipe_model.dart';
import '../../scheme/recipes_schema.dart';
import 'recipe_remote_data_source.dart';

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  RecipeRemoteDataSourceImpl({
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
      // Enforce the output shape so every recipe always carries all its
      // fields (no dropped keys when the model is unsure) — substitutes
      // and step timers in particular must always be present.
      responseSchema: RecipesSchema.responseSchema,
    ),
  );

  @override
  Future<String> getDietaryPreference() {
    return _supabaseService.safeCall(() async {
      final Map<String, dynamic>? row = await _client
          .from(SupabaseTable.usersTable)
          .select('dietary_preference')
          .eq('id', _requireUserId())
          .maybeSingle();
      final String? value = row?['dietary_preference'] as String?;
      return (value == null || value.isEmpty)
          ? GeminiConstants.defaultDiet
          : value;
    });
  }

  @override
  Future<List<SavedRecipeModel>> getSavedRecipes() {
    return _supabaseService.safeCall(() async {
      final List<Map<String, dynamic>> rows = await _client
          .from(SupabaseTable.savedRecipesTable)
          .select(
            'rating, saved_at, recipes(id, title, cook_time_minutes, mood)',
          )
          .eq('user_id', _requireUserId())
          .order('saved_at', ascending: false);
      return rows.map(SavedRecipeModel.fromSupabaseRow).toList();
    });
  }

  @override
  Future<RecipeModel> getRecipeById({required String id}) {
    return _supabaseService.safeCall(() async {
      final Map<String, dynamic> row = await _client
          .from(SupabaseTable.recipesTable)
          .select(
            'title, description, servings, cook_time_minutes, mood, '
            'recipe_steps(step_number, instruction, timer_seconds), '
            'recipe_ingredients(name, quantity, unit, is_substitute)',
          )
          .eq('id', id)
          // Steps must render in order; the embedded list isn't sorted by default.
          .order('step_number', referencedTable: SupabaseTable.recipeStepsTable)
          .single();
      return RecipeModel.fromSupabaseRow(row);
    });
  }

  @override
  Future<SavedRecipeModel> saveRecipe({
    required RecipeModel recipe,
    required int rating,
    String? note,
    String? scanId,
  }) {
    return _supabaseService.safeCall(() async {
      final String userId = _requireUserId();

      // 1. Insert the recipe header and take its generated id.
      final Map<String, dynamic> inserted = await _client
          .from(SupabaseTable.recipesTable)
          .insert(<String, dynamic>{
            'user_id': userId,
            'scan_id': scanId,
            'title': recipe.title,
            'description': recipe.description,
            'servings': recipe.servings,
            'cook_time_minutes': recipe.cookTimeMinutes,
            'mood': recipe.mood,
          })
          .select('id')
          .single();
      final String recipeId = inserted['id'] as String;

      // 2 & 3. Batch-insert the steps and ingredients against that recipe.
      await Future.wait(<Future<void>>[
        _insertSteps(recipeId, recipe.steps),
        _insertIngredients(recipeId, recipe.ingredients),
      ]);

      // 4. Link the recipe into the user's cookbook. The unique(user_id,
      //    recipe_id) constraint makes this safe against accidental dupes.
      //    Take back saved_at so the caller can cache an exact cookbook entry
      //    without a follow-up read.
      final Map<String, dynamic> link = await _client
          .from(SupabaseTable.savedRecipesTable)
          .insert(<String, dynamic>{
            'user_id': userId,
            'recipe_id': recipeId,
            'rating': rating,
            'note': note,
          })
          .select('saved_at')
          .single();

      return SavedRecipeModel(
        id: recipeId,
        title: recipe.title ?? 'Untitled recipe',
        cookTimeMinutes: recipe.cookTimeMinutes,
        mood: recipe.mood,
        rating: rating,
        savedAt: DateTime.parse(link['saved_at'] as String),
      );
    });
  }

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
      'AI recipe generation requested (${GeminiConstants.geminiModel}, mood: $mood, '
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
      throw const ServerException(
        "We couldn't write your recipes right now. Please try again.",
      );
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
    final String ingredientList = ingredientLines
        .map((String l) => '- $l')
        .join('\n');
    final bool hasDiet =
        dietaryPreference.isNotEmpty &&
        dietaryPreference.toLowerCase() != 'none';
    final String dietRule = hasDiet
        ? 'All recipes must be suitable for a $dietaryPreference diet.\n'
        : '';
    final String recipesPrompt =
        '''
You are a creative chef. Given these fridge ingredients:
$ingredientList

Generate exactly ${GeminiConstants.recipeCount} recipes matching the "$mood" mood.
$dietRule
Rules:
- Exactly ${GeminiConstants.recipeCount} recipes.
- Use the provided ingredients plus common pantry items (salt, oil, water, spices).
- Set "timer_seconds" for any timed step; use 0 when the step is not timed.
- Set "is_substitute" to true when an ingredient replaces a missing item.
- "step_number" starts at 1 and increases in order.
''';

    return recipesPrompt;
  }

  /// Parses the model's JSON into [RecipeModel]s, attaching the requested
  /// [mood] to each (it is a generation input, not part of the response).
  List<RecipeModel> _parseRecipes(String raw, String mood) {
    if (raw.trim().isEmpty) {
      throw const ServerException(
        'The AI returned an empty response. Please try again.',
      );
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
        throw const ServerException(
          'No recipes could be written from those ingredients. Please try again.',
        );
      }
      return recipes;
    } on FormatException catch (e, stackTrace) {
      _logger.error(
        'Failed to parse AI recipe response.',
        error: e,
        stackTrace: stackTrace,
      );
      throw const ServerException(
        "We couldn't read the recipes we generated. Please try again.",
      );
    }
  }

  Future<void> _insertSteps(
    String recipeId,
    List<RecipeStepModel> steps,
  ) async {
    if (steps.isEmpty) return;
    final List<Map<String, dynamic>> rows = steps
        .map(
          (RecipeStepModel s) => <String, dynamic>{
            'recipe_id': recipeId,
            'step_number': s.stepNumber,
            'instruction': s.instruction,
            // Normalise the prompt's 0 sentinel back to null for "no timer".
            'timer_seconds': (s.timerSeconds ?? 0) > 0 ? s.timerSeconds : null,
          },
        )
        .toList();
    await _client.from(SupabaseTable.recipeStepsTable).insert(rows);
  }

  Future<void> _insertIngredients(
    String recipeId,
    List<RecipeIngredientModel> ingredients,
  ) async {
    if (ingredients.isEmpty) return;
    final List<Map<String, dynamic>> rows = ingredients
        .map(
          (RecipeIngredientModel i) => <String, dynamic>{
            'recipe_id': recipeId,
            'name': i.name,
            'quantity': i.quantity,
            'unit': i.unit,
            'is_substitute': i.isSubstitute,
          },
        )
        .toList();
    await _client.from(SupabaseTable.recipeIngredientsTable).insert(rows);
  }

  /// Returns the current user id, or throws when there is no active session.
  String _requireUserId() {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw const InvalidCredentialsException(
        'You must be signed in to save a recipe.',
      );
    }
    return user.id;
  }
}
