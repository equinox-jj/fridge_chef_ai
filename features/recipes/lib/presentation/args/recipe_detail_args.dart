import '../../domain/entities/recipe_entity.dart';

/// In-memory hand-off to the recipe detail screen.
///
/// A generated recipe has no id yet, so it cannot be addressed by URL; it is
/// passed by value as a route `$extra`, together with the originating [scanId]
/// needed to link it when saved.
class RecipeDetailArgs {
  const RecipeDetailArgs({
    required this.recipe,
    this.scanId,
  });

  final RecipeEntity recipe;
  final String? scanId;
}
