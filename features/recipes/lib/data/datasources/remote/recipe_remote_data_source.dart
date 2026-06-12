import '../../models/recipe_model.dart';

/// Contract for the Supabase-backed recipe persistence and the user's dietary
/// preference read. Throws an [AppException] on failure.
abstract class RecipeRemoteDataSource {
  /// Reads the signed-in user's `dietary_preference`, or `none` when unset.
  Future<String> getDietaryPreference();

  /// Persists [recipe] across `recipes`, `recipe_steps` and
  /// `recipe_ingredients`, then links it into the user's cookbook via
  /// `saved_recipes` with [rating] and [note] (PRD §4.4.1).
  Future<void> saveRecipe({
    required RecipeModel recipe,
    required int rating,
    String? note,
    String? scanId,
  });
}
