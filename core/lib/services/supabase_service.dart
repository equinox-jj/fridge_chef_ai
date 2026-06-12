import 'dart:async';
import '../constants/exceptions/app_exceptions.dart';
import '../logger/app_logger.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

/// Service wrapper around the [SupabaseClient] to facilitate dependency injection,
/// centralize error/network handling, and expose database/auth clients.
class SupabaseService {
  SupabaseService(this._client, this._logger);

  final SupabaseClient _client;
  final AppLogger _logger;

  /// Exposes the underlying [SupabaseClient].
  SupabaseClient get client => _client;

  /// The currently authenticated session, or `null` when signed out.
  Session? get currentSession => _client.auth.currentSession;

  /// Emits on every authentication state change (sign-in, sign-out, refresh).
  ///
  /// Used as the router's refresh trigger so navigation reacts to auth changes.
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Wraps an asynchronous Supabase operation, catches exceptions,
  /// maps them to [AppException], and rethrows.
  ///
  /// The raw error is logged here — closest to the backend — so the original
  /// Supabase detail is captured before it is flattened into a domain
  /// [AppException]. It is logged at `warning` because a caller (e.g. a
  /// repository) may still recover from it.
  Future<T> safeCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (e, stackTrace) {
      _logger.warning(
        'Supabase call failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw mapException(e);
    }
  }

  /// Maps a dynamic exception/error to a domain-specific [AppException].
  AppException mapException(Object error) {
    if (error is AppException) {
      return error;
    }

    if (error is AuthException) {
      final String message = error.message;
      final String? status = error.statusCode;
      final String? errorCode = error.code;

      if (errorCode != null) {
        switch (errorCode) {
          case 'invalid_credentials':
            return const InvalidCredentialsException();
          case 'user_already_exists':
            return const UserAlreadyExistsException();
          case 'weak_password':
            return const WeakPasswordException();
          case 'invalid_email':
            return const InvalidEmailException();
          case 'email_not_confirmed':
            return const EmailNotConfirmedException();
          case 'rate_limit_exceeded':
            return const TooManyRequestsException();
        }
      }

      // Fallback mapping based on status code
      if (status == '400') {
        final String lowerMessage = message.toLowerCase();
        if (lowerMessage.contains('credentials') || lowerMessage.contains('invalid')) {
          return const InvalidCredentialsException();
        }
        if (lowerMessage.contains('already exists') || lowerMessage.contains('already registered')) {
          return const UserAlreadyExistsException();
        }
        if (lowerMessage.contains('password')) {
          return const WeakPasswordException();
        }
        if (lowerMessage.contains('email')) {
          return const InvalidEmailException();
        }
      }

      if (status == '429') {
        return const TooManyRequestsException();
      }

      return ServerException(message);
    }

    if (error is PostgrestException) {
      return ServerException(error.message);
    }

    if (error is TimeoutException) {
      return const NetworkException('Connection timed out. Please try again.');
    }

    // Check for SocketException or ClientException (network issues)
    final String errorString = error.toString().toLowerCase();
    if (errorString.contains('socketexception') ||
        errorString.contains('clientexception') ||
        errorString.contains('failed host lookup')) {
      return const NetworkException();
    }

    return UnknownAppException('An unexpected error occurred: ${error.toString()}');
  }
}
