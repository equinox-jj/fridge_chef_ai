/// Contract for profile operations backed by a remote service (Supabase).
///
/// Implementations throw an [AppException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class ProfileRemoteDataSource {
  /// Returns how many fridge scans the signed-in user has run.
  Future<int> getScanCount();

  /// Persists the user's dietary [preference] token on their user row — the
  /// source of truth the recipe prompt reads from.
  Future<void> updateDietaryPreference(String preference);

  /// Clears the current session.
  Future<void> signOut();
}
