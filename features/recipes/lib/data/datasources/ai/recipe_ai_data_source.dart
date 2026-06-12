import '../../models/recipe_model.dart';

/// Contract for the AI backend (Firebase AI) that writes recipes from a list of
/// ingredients. Throws an [AppException] on failure.
abstract class RecipeAiDataSource {
  /// Generates exactly three recipes from [ingredientLines] (one human-readable
  /// line per ingredient, e.g. "2 pcs egg") tuned to [mood], constrained to
  /// [dietaryPreference] when it is anything other than `none`.
  Future<List<RecipeModel>> generateRecipes({
    required List<String> ingredientLines,
    required String mood,
    required String dietaryPreference,
  });
}
