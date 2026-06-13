import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseClient get _client => _supabaseService.client;

  @override
  Future<int> getScanCount() {
    // Header-only exact count: the user's scan rows are tallied server-side,
    // none are transferred.
    return _supabaseService.safeCall(
      () => _client.from(SupabaseTable.fridgeScansTable).count(CountOption.exact).eq('user_id', _requireUserId()),
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
