import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/saved_recipe_entity.dart';
import '../repositories/recipe_repository.dart';

/// Emits the user's cookbook (saved recipes, newest first) and re-emits on
/// every change, so the cookbook grid stays live.
class WatchCookbookUseCase
    implements StreamUseCase<List<SavedRecipeEntity>, NoParams> {
  const WatchCookbookUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Stream<Either<Failure, List<SavedRecipeEntity>>> call(NoParams params) {
    return _repository.watchCookbook();
  }
}
