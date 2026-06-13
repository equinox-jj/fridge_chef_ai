// Prefixed so the Drift-generated `UserProfile` row can be named without
// clashing with the feature's `ProfileEntity` / other domain types.
import 'package:core/database/app_database.dart' as db;
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/cache_guard.dart';
import 'package:dependencies/drift/drift.dart';

import '../../../domain/entities/profile_entity.dart';
import 'profile_local_data_source.dart';

class ProfileLocalDataSourceImpl with CacheGuard implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl(this._database, this.logger);

  final db.AppDatabase _database;

  @override
  final AppLogger logger;

  @override
  Future<ProfileEntity?> getProfile() {
    return cacheGuard(() async {
      final db.UserProfile? row = await (_database.select(_database.userProfiles)..limit(1)).getSingleOrNull();
      if (row == null) {
        return null;
      }
      return ProfileEntity(
        name: row.name,
        email: row.email,
        avatarUrl: row.avatarUrl,
        dietaryPreference: row.dietaryPreferences,
      );
    });
  }

  @override
  Future<void> updateDietaryPreference(String preference) {
    // Exactly one row is cached (the current user), so an unfiltered update
    // targets it without needing the id.
    return cacheGuard(
      () => _database
          .update(_database.userProfiles)
          .write(
            db.UserProfilesCompanion(dietaryPreferences: Value<String?>(preference)),
          ),
    );
  }
}
