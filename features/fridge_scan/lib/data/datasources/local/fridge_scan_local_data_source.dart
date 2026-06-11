import '../../../domain/entities/user_profile.dart';

/// Reads the signed-in user's cached profile from the shared local database.
///
/// Implementations throw a [CacheException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class FridgeScanLocalDataSource {
  /// The cached profile, or `null` when nothing has been cached yet.
  Future<UserProfile?> getUserProfile();
}
