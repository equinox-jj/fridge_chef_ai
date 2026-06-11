import 'package:core/services/supabase_service.dart';

import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._supabaseService);

  final SupabaseService _supabaseService;

  @override
  Future<void> signOut() {
    return _supabaseService.safeCall(
      () => _supabaseService.client.auth.signOut(),
    );
  }
}
