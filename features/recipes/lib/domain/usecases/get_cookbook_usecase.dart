import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/saved_recipe_entity.dart';
import '../repositories/recipe_repository.dart';

/// Reads the user's cookbook (their saved recipes), newest first.
class GetCookbookUseCase implements UseCase<List<SavedRecipeEntity>, NoParams> {
  const GetCookbookUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<Either<Failure, List<SavedRecipeEntity>>> call(NoParams params) {
    return _repository.getCookbook();
  }
}
