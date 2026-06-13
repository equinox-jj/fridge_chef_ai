// Prefixed so the Drift-generated `UserProfile` row can be named without
// clashing with the domain entity of the same name.
import 'package:core/database/app_database.dart' as db;
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/cache_guard.dart';

import '../../../domain/entities/user_profile.dart';
import 'fridge_scan_local_data_source.dart';

class FridgeScanLocalDataSourceImpl with CacheGuard implements FridgeScanLocalDataSource {
  FridgeScanLocalDataSourceImpl(this._database, this.logger);

  final db.AppDatabase _database;

  @override
  final AppLogger logger;

  @override
  Stream<UserProfile?> watchUserProfile() {
    return cacheGuardStream(
      (_database.select(_database.userProfiles)..limit(1)).watchSingleOrNull().map((db.UserProfile? row) {
        if (row == null) {
          return null;
        }
        return UserProfile(
          name: row.name,
          email: row.email,
          avatarUrl: row.avatarUrl,
        );
      }),
    );
  }
}
