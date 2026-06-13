import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/profile_repository.dart';

/// Saves the user's chosen dietary preference token (e.g. `vegan`).
class UpdateDietaryPreferenceUseCase implements UseCase<Unit, String> {
  const UpdateDietaryPreferenceUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String preference) {
    return _repository.updateDietaryPreference(preference);
  }
}
