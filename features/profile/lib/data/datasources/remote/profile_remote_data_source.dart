/// Contract for profile operations backed by a remote service (Supabase).
///
/// Implementations throw an [AppException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class ProfileRemoteDataSource {
  /// Clears the current session.
  Future<void> signOut();
}
