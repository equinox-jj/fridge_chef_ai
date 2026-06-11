import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import '../../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._supabaseService);

  final SupabaseService _supabaseService;

  SupabaseClient get _client => _supabaseService.client;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) {
    return _supabaseService.safeCall(() async {
      final AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final User? user = response.user;
      if (user == null) {
        throw const InvalidCredentialsException();
      }
      return _fetchProfile(user.id);
    });
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _supabaseService.safeCall(() async {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
        data: <String, dynamic>{'name': name},
      );
      final User? user = response.user;
      if (user == null) {
        throw const ServerException('Sign up failed. Please try again.');
      }

      final Map<String, dynamic> inserted = await _client
          .from(SupabaseTable.usersTable)
          .insert(<String, dynamic>{
            'id': user.id,
            'name': name,
            'email': email,
          })
          .select()
          .single();

      return UserModel.fromJson(inserted);
    });
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return _supabaseService.safeCall(
      () => _client.auth.resetPasswordForEmail(email),
    );
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return _supabaseService.safeCall(() async {
      final User? user = _client.auth.currentUser;
      if (user == null) {
        return null;
      }
      return _fetchProfile(user.id);
    });
  }

  /// Fetches the `users` profile row for the given auth [id].
  Future<UserModel> _fetchProfile(String id) async {
    final Map<String, dynamic> data = await _client.from(SupabaseTable.usersTable).select().eq('id', id).single();
    return UserModel.fromJson(data);
  }
}
