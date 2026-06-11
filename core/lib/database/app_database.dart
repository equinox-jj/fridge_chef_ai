import 'package:dependencies/drift/drift.dart';
import 'package:dependencies/drift_flutter/drift_flutter.dart';

import 'tables/user_profile_table.dart';

part 'app_database.g.dart';

/// The app's shared local SQLite database (via Drift).
///
/// Lives in `core` so every feature can persist data through it while keeping
/// each feature's *access* logic (data sources) inside that feature.
@DriftDatabase(tables: <Type>[UserProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Opens with a caller-provided executor — used by tests (e.g. in-memory).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(name: 'app');
}
