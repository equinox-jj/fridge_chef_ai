import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/profile_repository.dart';

/// Signs the current user out.
class SignOutUseCase implements UseCase<Unit, NoParams> {
  const SignOutUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _repository.signOut();
  }
}
