import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/recipe_entity.dart';
import '../repositories/recipe_repository.dart';

class SaveRecipeParams {
  const SaveRecipeParams({
    required this.recipe,
    required this.rating,
    this.note,
    this.scanId,
  });

  final RecipeEntity recipe;
  final int rating;
  final String? note;
  final String? scanId;
}

/// Persists a recipe to the user's cookbook with a rating and optional note.
class SaveRecipeUseCase implements UseCase<Unit, SaveRecipeParams> {
  const SaveRecipeUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(SaveRecipeParams params) {
    return _repository.saveRecipe(
      recipe: params.recipe,
      rating: params.rating,
      note: params.note,
      scanId: params.scanId,
    );
  }
}
