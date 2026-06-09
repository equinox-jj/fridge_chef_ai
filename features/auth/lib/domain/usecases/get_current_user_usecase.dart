import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Returns the current session's user, or `null` when not signed in.
class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}
