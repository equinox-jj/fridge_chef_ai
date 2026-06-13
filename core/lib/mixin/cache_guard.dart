import '../constants/exceptions/app_exceptions.dart';
import '../logger/app_logger.dart';

/// Shared error-handling seam for local (cache) data sources.
///
/// Wrap a Drift/SQLite operation in [cacheGuard]: domain [AppException]s pass
/// through untouched, while any low-level storage error is logged and converted
/// to a [CacheException] so the repository can map it to a `Failure` — no local
/// data source needs its own try/catch boilerplate.
///
/// Implementers supply an injected [logger]:
///
/// ```dart
/// class AuthLocalDataSourceImpl with CacheGuard implements AuthLocalDataSource {
///   AuthLocalDataSourceImpl(this._database, this.logger);
///
///   final AppDatabase _database;
///   @override
///   final AppLogger logger;
///
///   @override
///   Future<UserModel?> getCachedUser() {
///     return cacheGuard(() async { ... });
///   }
/// }
/// ```
mixin CacheGuard {
  /// Logger used to record failures caught by [cacheGuard]; satisfied by an
  /// injected [AppLogger] on the data source.
  AppLogger get logger;

  /// Runs [action], passing through [AppException]s and converting any other
  /// (storage-level) error into a [CacheException]. The raw error is logged
  /// with its stack trace at `warning` — a caller may still recover from a
  /// cache miss.
  Future<T> cacheGuard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (e, stackTrace) {
      logger.warning(
        'Local cache operation failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(e.toString());
    }
  }

  /// Stream counterpart to [cacheGuard] for reactive (e.g. Drift `.watch()`)
  /// queries: each value flows through untouched, [AppException]s are forwarded
  /// as-is, and any other (storage-level) error is logged and re-thrown as a
  /// [CacheException] so the repository can map it to a `Failure`. The stream
  /// stays open after a recoverable error so later updates still arrive.
  Stream<T> cacheGuardStream<T>(Stream<T> source) {
    return source.handleError((Object e, StackTrace stackTrace) {
      logger.warning(
        'Local cache stream failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(e.toString());
    }, test: (Object? e) => e is! AppException);
  }
}
