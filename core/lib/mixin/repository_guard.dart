import 'package:dependencies/fpdart/fpdart.dart';

import '../constants/exceptions/app_exceptions.dart';
import '../constants/network/exception_to_failure.dart';
import '../constants/network/failure.dart';

/// Shared error-handling seam for repository implementations.
///
/// The data layer throws [AppException]s; the domain layer speaks
/// `Either<Failure, T>`. Mix this in and wrap each data-source call in [guard]
/// so a thrown [AppException] becomes a [Left] [Failure] while a returned value
/// becomes a [Right] — no repository needs its own try/catch boilerplate.
///
/// ```dart
/// class AuthRepositoryImpl with RepositoryGuard implements AuthRepository {
///   @override
///   Future<Either<Failure, UserEntity>> signIn(...) {
///     return guard(() async {
///       final model = await _remote.signIn(...);
///       return model.toEntity();
///     });
///   }
/// }
/// ```
mixin RepositoryGuard {
  /// Runs [call], converting any thrown [AppException] into a [Left] [Failure]
  /// and any successful result into a [Right].
  Future<Either<Failure, T>> guard<T>(Future<T> Function() call) async {
    try {
      return Right<Failure, T>(await call());
    } on AppException catch (e) {
      return Left<Failure, T>(e.toFailure());
    }
  }
}
