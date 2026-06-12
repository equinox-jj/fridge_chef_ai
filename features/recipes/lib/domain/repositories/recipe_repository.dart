import 'package:core/constants/network/failure.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/recipe_entity.dart';

/// Contract for recipe generation and persistence, spoken by the domain layer
/// as `Either<Failure, T>`.
abstract class RecipeRepository {
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
