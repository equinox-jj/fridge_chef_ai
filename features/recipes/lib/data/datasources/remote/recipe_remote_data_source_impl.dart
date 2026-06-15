import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import '../../models/recipe_ingredient_model.dart';
import '../../models/recipe_model.dart';
import '../../models/recipe_step_model.dart';
import '../../models/saved_recipe_model.dart';
import 'recipe_remote_data_source.dart';

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  RecipeRemoteDataSourceImpl({required this._supabaseService});

  final SupabaseService _supabaseService;

  /// Value stored for a user who has not set a dietary preference.
  static const String _defaultDiet = 'none';

  SupabaseClient get _client => _supabaseService.client;

  @override
  Future<String> getDietaryPreference() {
    return _supabaseService.safeCall(() async {
      final Map<String, dynamic>? row = await _client
          .from(SupabaseTable.usersTable)
          .select('dietary_preference')
          .eq('id', _requireUserId())
          .maybeSingle();
      final String? value = row?['dietary_preference'] as String?;
      return (value == null || value.isEmpty) ? _defaultDiet : value;
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
      await _insertSteps(recipeId, recipe.steps);
      await _insertIngredients(recipeId, recipe.ingredients);

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
