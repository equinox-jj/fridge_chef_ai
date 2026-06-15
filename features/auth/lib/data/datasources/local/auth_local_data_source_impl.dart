import 'package:core/database/app_database.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/cache_guard.dart';
import 'package:dependencies/drift/drift.dart';

import '../../models/user_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl with CacheGuard implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required this._database,
    required this.logger,
  });

  final AppDatabase _database;

  @override
  final AppLogger logger;

  @override
  Future<void> cacheUser({required UserModel user}) {
    return cacheGuard(
      () => _database.transaction(() async {
        await Future.wait(<Future<int>>[
          _database.delete(_database.userProfiles).go(),
          _database.into(_database.userProfiles).insert(user.toCompanion()),
        ]);
      }),
    );
  }

  @override
  Future<UserModel?> getCachedUser() {
    return cacheGuard(() async {
      final UserProfile? row = await _database
          .select(_database.userProfiles)
          .getSingleOrNull();
      return row?.toModel();
    });
  }

  @override
  Future<void> clear() {
    return cacheGuard(
      () => _database.delete(_database.userProfiles).go(),
    );
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
