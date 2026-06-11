abstract class Failure {
  const Failure(this.message, [this.code]);

  final String message;
  final String? code;
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'A server error occurred. Please try again later.',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'A network error occurred. Please check your internet connection.',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'A local storage error occurred.',
    super.code = 'cache_error',
  ]);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([
    super.message = 'Invalid email or password.',
    super.code = 'invalid_credentials',
  ]);
}

class UserAlreadyExistsFailure extends Failure {
  const UserAlreadyExistsFailure([
    super.message = 'A user with this email address already exists.',
    super.code = 'user_already_exists',
  ]);
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure([
    super.message = 'Password should be at least 6 characters.',
    super.code = 'weak_password',
  ]);
}

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure([
    super.message = 'The email address is invalid.',
    super.code = 'invalid_email',
  ]);
}

class EmailNotConfirmedFailure extends Failure {
  const EmailNotConfirmedFailure([
    super.message = 'Email address has not been confirmed.',
    super.code = 'email_not_confirmed',
  ]);
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure([
    super.message = 'Too many requests. Please try again later.',
    super.code = 'rate_limit_exceeded',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'An unknown authentication error occurred.',
    super.code = 'unknown_auth_error',
  ]);
}
