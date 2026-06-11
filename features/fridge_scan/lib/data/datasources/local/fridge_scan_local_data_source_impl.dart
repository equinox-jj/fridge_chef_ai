import 'package:core/constants/exceptions/app_exceptions.dart';
// Prefixed so the Drift-generated `UserProfile` row can be named without
// clashing with the domain entity of the same name.
import 'package:core/database/app_database.dart' as db;

import '../../../domain/entities/user_profile.dart';
import 'fridge_scan_local_data_source.dart';

class FridgeScanLocalDataSourceImpl implements FridgeScanLocalDataSource {
  FridgeScanLocalDataSourceImpl(this._database);

  final db.AppDatabase _database;

  @override
  Future<UserProfile?> getUserProfile() async {
    try {
      final db.UserProfile? row = await (_database.select(_database.userProfiles)..limit(1)).getSingleOrNull();
      if (row == null) {
        return null;
      }
      return UserProfile(
        name: row.name,
        email: row.email,
        avatarUrl: row.avatarUrl,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
