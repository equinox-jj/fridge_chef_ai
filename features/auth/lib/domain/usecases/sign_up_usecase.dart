import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpParams {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}

/// Registers a new user and creates their profile.
class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return _repository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
