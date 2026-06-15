import 'dart:typed_data';

/// Contract for profile operations backed by a remote service (Supabase).
///
/// Implementations throw an [AppException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class ProfileRemoteDataSource {
  /// Returns how many fridge scans the signed-in user has run.
  Future<int> getScanCount();

  /// Persists the user's dietary [preference] token on their user row — the
  /// source of truth the recipe prompt reads from.
  Future<void> updateDietaryPreference({required String preference});

  /// Clears the current session.
  Future<void> signOut();

  /// Uploads [bytes] to the `avatars` storage bucket (overwriting the user's
  /// single avatar object) and returns a fresh signed URL for it.
  Future<String> uploadAvatar({required Uint8List bytes});

  /// Sets the user's `avatar_url` column. Pass `null` to clear it.
  Future<void> updateAvatarUrl({required String? url});

  /// Deletes the user's avatar object from the `avatars` storage bucket.
  Future<void> deleteAvatar();
}
