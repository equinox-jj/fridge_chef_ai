import 'package:dependencies/drift/drift.dart';
import 'package:dependencies/drift_flutter/drift_flutter.dart';

import 'tables/recipe_detail_table.dart';
import 'tables/saved_recipe_table.dart';
import 'tables/user_profile_table.dart';

part 'app_database.g.dart';

/// The app's shared local SQLite database (via Drift).
///
/// Lives in `core` so every feature can persist data through it while keeping
/// each feature's *access* logic (data sources) inside that feature.
@DriftDatabase(
  tables: <Type>[
    UserProfiles,
    SavedRecipeRows,
    RecipeDetailRows,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Opens with a caller-provided executor — used by tests (e.g. in-memory).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 3;

  /// Creates everything on a fresh install; on upgrade, adds only what's new so
  /// existing cached data (e.g. the user profile) survives. v2 introduces the
  /// offline cookbook cache ([SavedRecipeRows]); v3 adds the full-recipe detail
  /// cache ([RecipeDetailRows]).
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) => m.createAll(),
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(savedRecipeRows);
      }
      if (from < 3) {
        await m.createTable(recipeDetailRows);
      }
    },
  );

  static QueryExecutor _openConnection() => driftDatabase(name: 'app');
}
