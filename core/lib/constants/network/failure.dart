abstract class Failure {
  const Failure(this.message, [this.code]);

  /// User-facing, plain-language description shown directly in the UI.
  ///
  /// Inherited from the originating [AppException] via `toFailure()`, so it is
  /// already guaranteed to be free of raw backend/SQL/exception text.
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
    super.message =
        'A network error occurred. Please check your internet connection.',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([
    super.message = "Couldn't access your saved data. Please try again.",
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

class NoFoodDetectedFailure extends Failure {
  const NoFoodDetectedFailure([
    super.message =
        "We couldn't find any food in that photo. Try a clear photo of the inside of your fridge.",
    super.code = 'no_food_detected',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'Something went wrong. Please try again.',
    super.code = 'unknown_error',
  ]);
}

class PermissionFailure extends Failure {
  const PermissionFailure([
    super.message =
        'Permission denied. Please allow access in Settings to continue.',
    super.code = 'permission_denied',
  ]);
}
