import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseClient get _client => _supabaseService.client;

  static const String _avatarBucket = 'avatars';

  /// Signed-URL lifetime: one year, in seconds (mirrors the fridge-scan path).
  static const int _avatarSignedUrlTtl = 60 * 60 * 24 * 365;

  @override
  Future<int> getScanCount() {
    // Header-only exact count: the user's scan rows are tallied server-side,
    // none are transferred.
    return _supabaseService.safeCall(
      () => _client
          .from(SupabaseTable.fridgeScansTable)
          .count(CountOption.exact)
          .eq('user_id', _requireUserId()),
    );
  }

  @override
  Future<void> updateDietaryPreference(String preference) {
    return _supabaseService.safeCall(
      () => _client
          .from(SupabaseTable.usersTable)
          .update(<String, dynamic>{'dietary_preference': preference})
          .eq('id', _requireUserId()),
    );
  }

  @override
  Future<void> signOut() {
    return _supabaseService.safeCall(
      () => _client.auth.signOut(),
    );
  }

  @override
  Future<String> uploadAvatar(Uint8List bytes) {
    return _supabaseService.safeCall(() async {
      final String userId = _requireUserId();
      // One object per user, overwritten on each change. The returned signed
      // URL carries a fresh token each upload, so it doubles as cache-busting
      // for the existing `NetworkImage`.
      final String path = '$userId/avatar.jpg';
      await _client.storage
          .from(_avatarBucket)
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );
      return _client.storage
          .from(_avatarBucket)
          .createSignedUrl(path, _avatarSignedUrlTtl);
    });
  }

  @override
  Future<void> updateAvatarUrl(String? url) {
    return _supabaseService.safeCall(
      () => _client
          .from(SupabaseTable.usersTable)
          .update(<String, dynamic>{'avatar_url': url})
          .eq('id', _requireUserId()),
    );
  }

  @override
  Future<void> deleteAvatar() {
    return _supabaseService.safeCall(
      () => _client.storage.from(_avatarBucket).remove(<String>[
        '${_requireUserId()}/avatar.jpg',
      ]),
    );
  }

  /// Returns the current user id, or throws when there is no active session.
  String _requireUserId() {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw const InvalidCredentialsException(
        'You must be signed in to view your profile.',
      );
    }
    return user.id;
  }
}
