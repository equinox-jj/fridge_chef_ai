import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInParams {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;
}

/// Signs an existing user in with email and password.
class SignInUseCase implements UseCase<UserEntity, SignInParams> {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return _repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}
