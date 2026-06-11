import '../../models/user_model.dart';

/// Contract for authentication operations backed by a remote service (Supabase).
///
/// Implementations throw an [AppException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class AuthRemoteDataSource {
  /// Signs the user in with [email] and [password] and returns their profile.
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// Registers a new account and creates the matching `users` profile row.
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Sends a password-reset email to [email].
  Future<void> forgotPassword({required String email});

  /// Returns the profile of the currently authenticated user, or `null` when
  /// there is no active session.
  Future<UserModel?> getCurrentUser();
}
