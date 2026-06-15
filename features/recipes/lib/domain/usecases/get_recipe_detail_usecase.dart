import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/recipe_entity.dart';
import '../repositories/recipe_repository.dart';

/// Reads the full detail of a saved recipe by its [id] — cache-first, so it
/// works offline once the recipe has been opened online.
class GetRecipeDetailUseCase implements UseCase<RecipeEntity, String> {
  const GetRecipeDetailUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<Either<Failure, RecipeEntity>> call(String id) {
    return _repository.getRecipeDetail(id: id);
  }
}
