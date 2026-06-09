import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

class ForgotPasswordParams {
  const ForgotPasswordParams({required this.email});

  final String email;
}

/// Sends a password-reset email to the given address.
class ForgotPasswordUseCase implements UseCase<Unit, ForgotPasswordParams> {
  const ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(ForgotPasswordParams params) {
    return _repository.forgotPassword(email: params.email);
  }
}
