import '../../../domain/entities/user_profile.dart';
import '../../models/scan_model.dart';

/// Reads the signed-in user's cached profile and recent scans from the shared
/// local database.
///
/// Implementations throw a [CacheException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class FridgeScanLocalDataSource {
  /// Emits the cached profile (or `null` when nothing has been cached yet) and
  /// re-emits whenever the underlying row changes, so callers stay in sync with
  /// the local database in real time.
  Stream<UserProfile?> watchUserProfile();

  /// Returns the cached recent scans, newest first, capped at [limit].
  Future<List<ScanWithIngredients>> getRecentScans({int limit});

  /// Replaces the whole recent-scans cache with [scans] (the offline mirror of
  /// the backend, refreshed when online).
  Future<void> replaceRecentScans(List<ScanWithIngredients> scans);
}
