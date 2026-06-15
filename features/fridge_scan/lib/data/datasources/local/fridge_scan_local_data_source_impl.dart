import 'dart:convert';

// Prefixed so the Drift-generated `UserProfile` row can be named without
// clashing with the domain entity of the same name.
import 'package:core/database/app_database.dart' as db;
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/cache_guard.dart';
import 'package:dependencies/drift/drift.dart';

import '../../../domain/entities/user_profile.dart';
import '../../models/ingredient_model.dart';
import '../../models/scan_model.dart';
import 'fridge_scan_local_data_source.dart';

class FridgeScanLocalDataSourceImpl
    with CacheGuard
    implements FridgeScanLocalDataSource {
  FridgeScanLocalDataSourceImpl(this._database, this.logger);

  final db.AppDatabase _database;

  @override
  final AppLogger logger;

  @override
  Stream<UserProfile?> watchUserProfile() {
    return cacheGuardStream(
      (_database.select(
        _database.userProfiles,
      )..limit(1)).watchSingleOrNull().map((db.UserProfile? row) {
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

  @override
  Future<List<ScanWithIngredients>> getRecentScans({int limit = 10}) {
    return cacheGuard(() async {
      final List<db.CachedScanRow> rows =
          await (_database.select(_database.cachedScanRows)
                ..orderBy(<OrderingTerm Function(db.$CachedScanRowsTable)>[
                  (db.$CachedScanRowsTable t) => OrderingTerm.desc(t.scannedAt),
                ])
                ..limit(limit))
              .get();
      return rows.map(_decode).toList();
    });
  }

  @override
  Future<void> replaceRecentScans(List<ScanWithIngredients> scans) {
    // Replace-then-insert keeps the cache an exact mirror of the backend, so a
    // scan deleted remotely doesn't linger offline.
    return cacheGuard(
      () => _database.transaction(() async {
        await _database.delete(_database.cachedScanRows).go();
        await _database.batch((Batch batch) {
          batch.insertAll(
            _database.cachedScanRows,
            scans.map(_toCompanion),
          );
        });
      }),
    );
  }

  /// Serialises a scan and its ingredients into a single cache row. The scan id
  /// and timestamp fall back to safe defaults so a malformed remote row can't
  /// break the primary key or the display ordering.
  db.CachedScanRowsCompanion _toCompanion(ScanWithIngredients item) {
    return db.CachedScanRowsCompanion(
      id: Value<String>(item.scan.id ?? ''),
      payload: Value<String>(
        jsonEncode(<String, dynamic>{
          'scan': item.scan.toJson(),
          'ingredients': item.ingredients
              .map((IngredientModel i) => i.toJson())
              .toList(),
        }),
      ),
      scannedAt: Value<DateTime>(item.scan.scannedAt ?? DateTime.now()),
    );
  }

  /// Inverse of [_toCompanion]: rebuilds the scan/ingredients composite from a
  /// cached row's JSON payload.
  ScanWithIngredients _decode(db.CachedScanRow row) {
    final Map<String, dynamic> json =
        jsonDecode(row.payload) as Map<String, dynamic>;
    final List<dynamic> rawIngredients =
        json['ingredients'] as List<dynamic>? ?? <dynamic>[];
    return (
      scan: ScanModel.fromJson(json['scan'] as Map<String, dynamic>),
      ingredients: rawIngredients
          .whereType<Map<String, dynamic>>()
          .map(IngredientModel.fromJson)
          .toList(),
    );
  }
}
