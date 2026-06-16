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

  /// Emits the cached recent scans (newest first, capped at [limit]) and
  /// re-emits whenever the cache changes, so callers stay in sync in real time.
  Stream<List<ScanWithIngredients>> watchRecentScans({int limit});

  /// Inserts or updates a single scan in the cache — used to write a freshly
  /// completed scan straight into the cache so the home list shows it instantly.
  Future<void> upsertScan(ScanWithIngredients scan);

  /// Replaces the whole recent-scans cache with [scans] (the offline mirror of
  /// the backend, refreshed when online).
  Future<void> replaceRecentScans({required List<ScanWithIngredients> scans});
}
