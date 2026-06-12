import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/recipe_repository.dart';

/// Reads the signed-in user's dietary preference, used to pre-fill the mood
/// screen and inject into the generation prompt.
class GetDietaryPreferenceUseCase implements UseCase<String, NoParams> {
  const GetDietaryPreferenceUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return _repository.getDietaryPreference();
  }
}
