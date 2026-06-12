import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import '../../models/recipe_ingredient_model.dart';
import '../../models/recipe_model.dart';
import '../../models/recipe_step_model.dart';
import 'recipe_remote_data_source.dart';

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  RecipeRemoteDataSourceImpl(this._supabaseService);

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
  Future<void> saveRecipe({
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
      await _client.from(SupabaseTable.savedRecipesTable).insert(<String, dynamic>{
        'user_id': userId,
        'recipe_id': recipeId,
        'rating': rating,
        'note': note,
      });
    });
  }

  Future<void> _insertSteps(String recipeId, List<RecipeStepModel> steps) async {
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

  Future<void> _insertIngredients(String recipeId, List<RecipeIngredientModel> ingredients) async {
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
