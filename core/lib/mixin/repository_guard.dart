import 'dart:async';

import 'package:dependencies/fpdart/fpdart.dart';

import '../constants/exceptions/app_exceptions.dart';
import '../constants/network/exception_to_failure.dart';
import '../constants/network/failure.dart';
import '../logger/app_logger.dart';

/// Shared error-handling seam for repository implementations.
///
/// The data layer throws [AppException]s; the domain layer speaks
/// `Either<Failure, T>`. Mix this in and wrap each data-source call in [guard]
/// so a thrown [AppException] becomes a [Left] [Failure] while a returned value
/// becomes a [Right] — no repository needs its own try/catch boilerplate, and
/// every failure is logged once, in one place.
///
/// Implementers supply an injected [logger]:
///
/// ```dart
/// class AuthRepositoryImpl with RepositoryGuard implements AuthRepository {
///   AuthRepositoryImpl(this._remote, this._logger);
///
///   final AuthRemoteDataSource _remote;
///   @override
///   final AppLogger logger;
///
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
  /// Logger used to record failures caught by [guard]; satisfied by an injected
  /// [AppLogger] on the repository.
  AppLogger get logger;

  /// Runs [call], converting any thrown [AppException] into a [Left] [Failure]
  /// and any successful result into a [Right]. Caught exceptions are logged
  /// with their stack trace before being mapped, so the failure path is
  /// observable across every repository without per-call logging.
  Future<Either<Failure, T>> guard<T>(Future<T> Function() call) async {
    try {
      return Right<Failure, T>(await call());
    } on AppException catch (e, stackTrace) {
      logger.error(
        'Repository call failed: ${e.runtimeType}',
        error: e,
        stackTrace: stackTrace,
      );
      return Left<Failure, T>(e.toFailure());
    }
  }

  /// Stream counterpart to [guard]: each value from [source] is wrapped in a
  /// [Right], while a thrown [AppException] is logged and emitted as a [Left]
  /// [Failure] without closing the stream — so a transient error doesn't kill
  /// a long-lived (e.g. Drift `.watch()`) subscription and later updates still
  /// reach the caller. Any non-[AppException] is forwarded as a stream error.
  Stream<Either<Failure, T>> guardStream<T>(Stream<T> source) {
    return source.transform(
      StreamTransformer<T, Either<Failure, T>>.fromHandlers(
        handleData: (T data, EventSink<Either<Failure, T>> sink) {
          sink.add(Right<Failure, T>(data));
        },
        handleError: (Object error, StackTrace stackTrace, EventSink<Either<Failure, T>> sink) {
          if (error is AppException) {
            logger.error(
              'Repository stream failed: ${error.runtimeType}',
              error: error,
              stackTrace: stackTrace,
            );
            sink.add(Left<Failure, T>(error.toFailure()));
          } else {
            sink.addError(error, stackTrace);
          }
        },
      ),
    );
  }
}
