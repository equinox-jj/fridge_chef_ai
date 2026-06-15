import '../../models/user_model.dart';

/// Contract for caching the user's profile in the local database.
///
/// Implementations throw a [CacheException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class AuthLocalDataSource {
  /// Persists [user] as the single cached profile, replacing any previous one.
  Future<void> cacheUser({required UserModel user});

  /// Returns the cached profile, or `null` when nothing has been cached yet.
  Future<UserModel?> getCachedUser();

  /// Clears the cached profile (e.g. on sign-out).
  Future<void> clear();
}
