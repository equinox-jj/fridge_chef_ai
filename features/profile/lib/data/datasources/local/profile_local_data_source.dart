import '../../../domain/entities/profile_entity.dart';

/// Reads and updates the signed-in user's locally cached profile.
///
/// Backed by the shared on-device database (the `user_profiles` table the auth
/// feature keeps in sync), so the Profile screen renders instantly and offline.
abstract class ProfileLocalDataSource {
  /// Returns the cached profile, or `null` when none has been cached yet.
  Future<ProfileEntity?> getProfile();

  /// Updates the cached dietary-preference token so the UI reflects a change
  /// without waiting for the next remote sync.
  Future<void> updateDietaryPreference({required String preference});

  /// Updates the cached `avatar_url` so the header reflects a change without a
  /// remote round-trip. Pass `null` to clear it.
  Future<void> updateAvatarUrl({required String? url});
}
