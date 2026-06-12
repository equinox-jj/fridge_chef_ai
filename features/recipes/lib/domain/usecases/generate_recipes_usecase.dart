import 'package:core/constants/network/failure.dart';
import 'package:core/router/recipe_generation_args.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/recipe_entity.dart';
import '../repositories/recipe_repository.dart';

class GenerateRecipesParams {
  const GenerateRecipesParams({
    required this.ingredients,
    required this.mood,
    required this.dietaryPreference,
  });

  final List<RecipeSeedIngredient> ingredients;
  final String mood;
  final String dietaryPreference;
}

/// Generates three recipes from the reviewed ingredients, mood and dietary
/// preference.
class GenerateRecipesUseCase implements UseCase<List<RecipeEntity>, GenerateRecipesParams> {
  const GenerateRecipesUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(GenerateRecipesParams params) {
    return _repository.generateRecipes(
      ingredients: params.ingredients,
      mood: params.mood,
      dietaryPreference: params.dietaryPreference,
    );
  }
}
