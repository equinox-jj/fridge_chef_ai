import '../../../domain/entities/user_profile.dart';

/// Reads the signed-in user's cached profile from the shared local database.
///
/// Implementations throw a [CacheException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class FridgeScanLocalDataSource {
  /// Emits the cached profile (or `null` when nothing has been cached yet) and
  /// re-emits whenever the underlying row changes, so callers stay in sync with
  /// the local database in real time.
  Stream<UserProfile?> watchUserProfile();
}
