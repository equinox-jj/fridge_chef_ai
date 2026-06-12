abstract class AppException implements Exception {
  const AppException(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  String toString() => 'AppException: $message ${code != null ? '(Code: $code)' : ''}';
}

class ServerException extends AppException {
  const ServerException([
    super.message = 'A server error occurred. Please try again later.',
  ]);
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = 'A network error occurred. Please check your internet connection.',
  ]);
}

class CacheException extends AppException {
  const CacheException([
    super.message = 'A local storage error occurred.',
    super.code = 'cache_error',
  ]);
}

class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException([
    super.message = 'Invalid email or password.',
    super.code = 'invalid_credentials',
  ]);
}

class UserAlreadyExistsException extends AppException {
  const UserAlreadyExistsException([
    super.message = 'A user with this email address already exists.',
    super.code = 'user_already_exists',
  ]);
}

class WeakPasswordException extends AppException {
  const WeakPasswordException([
    super.message = 'Password should be at least 6 characters.',
    super.code = 'weak_password',
  ]);
}

class InvalidEmailException extends AppException {
  const InvalidEmailException([
    super.message = 'The email address is invalid.',
    super.code = 'invalid_email',
  ]);
}

class EmailNotConfirmedException extends AppException {
  const EmailNotConfirmedException([
    super.message = 'Email address has not been confirmed.',
    super.code = 'email_not_confirmed',
  ]);
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException([
    super.message = 'Too many requests. Please try again later.',
    super.code = 'rate_limit_exceeded',
  ]);
}

class NoFoodDetectedException extends AppException {
  const NoFoodDetectedException([
    super.message = "We couldn't find any food in that photo. Try a clear photo of the inside of your fridge.",
    super.code = 'no_food_detected',
  ]);
}

class UnknownAppException extends AppException {
  const UnknownAppException([
    super.message = 'An unknown authentication error occurred.',
    super.code = 'unknown_auth_error',
  ]);
}
