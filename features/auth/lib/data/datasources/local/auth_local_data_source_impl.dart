import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/database/app_database.dart';
import 'package:dependencies/drift/drift.dart';

import '../../models/user_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<void> cacheUser(UserModel user) {
    // Replace-then-insert keeps exactly one cached profile: the current user.
    return _guard(
      () => _database.transaction(() async {
        await _database.delete(_database.userProfiles).go();
        await _database.into(_database.userProfiles).insert(user.toCompanion());
      }),
    );
  }

  @override
  Future<UserModel?> getCachedUser() {
    return _guard(() async {
      final UserProfile? row = await _database.select(_database.userProfiles).getSingleOrNull();
      return row?.toModel();
    });
  }

  @override
  Future<void> clear() {
    return _guard(() => _database.delete(_database.userProfiles).go());
  }

  /// Runs [action], converting any low-level Drift/SQLite error into a
  /// [CacheException] so the repository can map it to a `Failure`.
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}

/// Maps between the data-layer [UserModel] and the Drift row/companion.
extension on UserModel {
  UserProfilesCompanion toCompanion() {
    return UserProfilesCompanion(
      id: Value<String>(id ?? ''),
      name: Value<String?>(name),
      email: Value<String?>(email),
      avatarUrl: Value<String?>(avatarUrl),
      dietaryPreferences: Value<String?>(dietaryPreferences),
      createdAt: Value<DateTime?>(createdAt),
    );
  }
}

extension on UserProfile {
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      dietaryPreferences: dietaryPreferences,
      createdAt: createdAt,
    );
  }
}
