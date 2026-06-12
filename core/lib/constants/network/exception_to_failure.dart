import '../exceptions/app_exceptions.dart';
import 'failure.dart';

/// Maps a domain [AppException] (thrown by data sources) to a presentation-safe
/// [Failure] that repositories can surface through `Either<Failure, T>`.
extension AppExceptionToFailure on AppException {
  Failure toFailure() {
    return switch (this) {
      InvalidCredentialsException() => InvalidCredentialsFailure(message),
      UserAlreadyExistsException() => UserAlreadyExistsFailure(message),
      WeakPasswordException() => WeakPasswordFailure(message),
      InvalidEmailException() => InvalidEmailFailure(message),
      EmailNotConfirmedException() => EmailNotConfirmedFailure(message),
      TooManyRequestsException() => TooManyRequestsFailure(message),
      NetworkException() => NetworkFailure(message),
      CacheException() => CacheFailure(message),
      NoFoodDetectedException() => NoFoodDetectedFailure(message),
      ServerException() => ServerFailure(message),
      _ => UnknownFailure(message),
    };
  }
}
