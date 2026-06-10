import 'package:dependencies/logger/logger.dart';

/// App-wide logging contract.
///
/// Declared in `core` so every layer can log against the abstraction without
/// binding to a concrete logging package. Swap [AppLoggerImpl] for a no-op or a
/// crash-reporting sink in tests/production without touching call sites.
abstract interface class AppLogger {
  /// Verbose diagnostic detail, useful only while developing.
  void debug(String message, {Object? error, StackTrace? stackTrace});

  /// Notable but expected events (navigation, lifecycle, successful calls).
  void info(String message, {Object? error, StackTrace? stackTrace});

  /// Recoverable problems that deserve attention but are not failures.
  void warning(String message, {Object? error, StackTrace? stackTrace});

  /// Failures — caught exceptions, error states, broken invariants.
  void error(String message, {Object? error, StackTrace? stackTrace});
}

/// [AppLogger] backed by the `logger` package with a readable pretty printer.
///
/// The default [Logger] only emits in debug builds (its [DevelopmentFilter]),
/// so leaving log calls in shipped code is safe. Pass a custom [Logger] to
/// change formatting, filtering, or output (e.g. routing to Crashlytics).
class AppLoggerImpl implements AppLogger {
  AppLoggerImpl([Logger? logger])
    : _logger =
          logger ??
          Logger(
            printer: PrettyPrinter(
              methodCount: 1,
              errorMethodCount: 8,
              lineLength: 100,
            ),
          );

  final Logger _logger;

  @override
  void debug(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _logger.d(
    message,
    error: error,
    stackTrace: stackTrace,
  );

  @override
  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _logger.i(
    message,
    error: error,
    stackTrace: stackTrace,
  );

  @override
  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _logger.w(
    message,
    error: error,
    stackTrace: stackTrace,
  );

  @override
  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _logger.e(
    message,
    error: error,
    stackTrace: stackTrace,
  );
}
