import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Returns the locally cached user profile, or `null` when nothing is cached.
///
/// Reads only from the local database — never hits the network.
class GetCachedUserUseCase implements UseCase<UserEntity?, NoParams> {
  const GetCachedUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return _repository.getCachedUser();
  }
}
