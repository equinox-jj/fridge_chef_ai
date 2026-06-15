import 'package:core/constants/network/failure.dart';
import 'package:core/router/args/recipe_generation_args.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/recipe_entity.dart';
import '../entities/saved_recipe_entity.dart';

/// Contract for recipe generation and persistence, spoken by the domain layer
/// as `Either<Failure, T>`.
abstract class RecipeRepository {
  /// Reads the user's cookbook (saved recipes), newest first.
  ///
  /// Offline-first: served from the on-device cache so it works without a
  /// network connection; when online the cache is refreshed from the backend
  /// first (PRD §4.4).
  Future<Either<Failure, List<SavedRecipeEntity>>> getCookbook();

  /// Reads the full detail (header, steps, ingredients) of the saved recipe
  /// [id], for the detail screen opened from the cookbook.
  ///
  /// Cache-first: when online, fetches from the backend and caches it for
  /// offline reading; otherwise (or if the fetch fails) serves the cached copy.
  /// Fails only when there's nothing cached and no way to reach the backend.
  Future<Either<Failure, RecipeEntity>> getRecipeDetail({required String id});

  /// Generates exactly three recipes from [ingredients] tuned to [mood],
  /// honouring [dietaryPreference] (the raw value, e.g. `none`/`vegetarian`).
  Future<Either<Failure, List<RecipeEntity>>> generateRecipes({
    required List<RecipeSeedIngredient> ingredients,
    required String mood,
    required String dietaryPreference,
  });

  /// Reads the signed-in user's dietary preference (the raw value), defaulting
  /// to `none` when unset.
  Future<Either<Failure, String>> getDietaryPreference();

  /// Persists [recipe] (header, steps, ingredients) and saves it to the user's
  /// cookbook with [rating] and an optional [note], linked back to [scanId]
  /// when present (PRD §4.4.1).
  Future<Either<Failure, Unit>> saveRecipe({
    required RecipeEntity recipe,
    required int rating,
    String? note,
    String? scanId,
  });
}
