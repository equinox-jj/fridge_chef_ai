import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/profile_repository.dart';

/// Clears the user's avatar.
class RemoveAvatarUseCase implements UseCase<Unit, NoParams> {
  const RemoveAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _repository.removeAvatar();
  }
}
