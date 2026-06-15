import '../../models/recipe_model.dart';
import '../../models/saved_recipe_model.dart';

/// Contract for the Supabase-backed recipe persistence and the user's dietary
/// preference read. Throws an [AppException] on failure.
abstract class RecipeRemoteDataSource {
  /// Reads the signed-in user's `dietary_preference`, or `none` when unset.
  Future<String> getDietaryPreference();

  /// Reads the user's cookbook from `saved_recipes` joined to `recipes`,
  /// newest first — the summaries needed to render and cache the grid.
  Future<List<SavedRecipeModel>> getSavedRecipes();

  /// Reads a single saved recipe's full detail — its `recipes` header with the
  /// embedded `recipe_steps` (ordered) and `recipe_ingredients` — by [id], for
  /// the detail screen opened from the cookbook.
  Future<RecipeModel> getRecipeById({required String id});

  /// Persists [recipe] across `recipes`, `recipe_steps` and
  /// `recipe_ingredients`, then links it into the user's cookbook via
  /// `saved_recipes` with [rating] and [note] (PRD §4.4.1).
  ///
  /// Returns the resulting cookbook entry (id + server timestamp) so the
  /// repository can write it straight into the offline cache.
  Future<SavedRecipeModel> saveRecipe({
    required RecipeModel recipe,
    required int rating,
    String? note,
    String? scanId,
  });

  /// Generates exactly three recipes from [ingredientLines] (one human-readable
  /// line per ingredient, e.g. "2 pcs egg") tuned to [mood], constrained to
  /// [dietaryPreference] when it is anything other than `none`.
  Future<List<RecipeModel>> generateRecipes({
    required List<String> ingredientLines,
    required String mood,
    required String dietaryPreference,
  });
}
