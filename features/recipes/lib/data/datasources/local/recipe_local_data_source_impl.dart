import 'dart:convert';

import 'package:core/database/app_database.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/cache_guard.dart';
import 'package:dependencies/drift/drift.dart';

import '../../models/recipe_model.dart';
import '../../models/saved_recipe_model.dart';
import 'recipe_local_data_source.dart';

class RecipeLocalDataSourceImpl
    with CacheGuard
    implements RecipeLocalDataSource {
  RecipeLocalDataSourceImpl(this._database, this.logger);

  final AppDatabase _database;

  @override
  final AppLogger logger;

  @override
  Future<List<SavedRecipeModel>> getCookbook() {
    return cacheGuard(() async {
      final List<SavedRecipeRow> rows =
          await (_database.select(_database.savedRecipeRows)
                ..orderBy(<OrderingTerm Function($SavedRecipeRowsTable)>[
                  ($SavedRecipeRowsTable t) => OrderingTerm.desc(t.savedAt),
                ]))
              .get();
      return rows.map((SavedRecipeRow row) => row.toModel()).toList();
    });
  }

  @override
  Future<void> replaceCookbook(List<SavedRecipeModel> recipes) {
    // Replace-then-insert keeps the cache an exact mirror of the backend, so a
    // recipe deleted remotely doesn't linger offline.
    return cacheGuard(
      () => _database.transaction(() async {
        await _database.delete(_database.savedRecipeRows).go();
        await _database.batch((Batch batch) {
          batch.insertAll(
            _database.savedRecipeRows,
            recipes.map((SavedRecipeModel r) => r.toCompanion()),
          );
        });
      }),
    );
  }

  @override
  Future<void> upsert(SavedRecipeModel recipe) {
    return cacheGuard(
      () => _database
          .into(_database.savedRecipeRows)
          .insertOnConflictUpdate(recipe.toCompanion()),
    );
  }

  @override
  Future<RecipeModel?> getRecipeDetail(String id) {
    return cacheGuard(() async {
      final RecipeDetailRow? row =
          await (_database.select(
                _database.recipeDetailRows,
              )..where(($RecipeDetailRowsTable t) => t.id.equals(id)))
              .getSingleOrNull();
      if (row == null) return null;
      final Map<String, dynamic> json =
          jsonDecode(row.payload) as Map<String, dynamic>;
      // `mood` is excluded from RecipeModel.fromJson (it's a generation input),
      // so re-attach it from the stored payload, where toJson did write it.
      return RecipeModel.fromJson(json).copyWith(mood: json['mood'] as String?);
    });
  }

  @override
  Future<void> cacheRecipeDetail(String id, RecipeModel recipe) {
    return cacheGuard(
      () => _database
          .into(_database.recipeDetailRows)
          .insertOnConflictUpdate(
            RecipeDetailRowsCompanion(
              id: Value<String>(id),
              payload: Value<String>(jsonEncode(recipe.toJson())),
              cachedAt: Value<DateTime>(DateTime.now()),
            ),
          ),
    );
  }
}

/// Maps between the data-layer [SavedRecipeModel] and the Drift row/companion.
extension on SavedRecipeModel {
  SavedRecipeRowsCompanion toCompanion() {
    return SavedRecipeRowsCompanion(
      id: Value<String>(id),
      title: Value<String>(title),
      cookTimeMinutes: Value<int?>(cookTimeMinutes),
      mood: Value<String?>(mood),
      rating: Value<int>(rating),
      savedAt: Value<DateTime>(savedAt),
    );
  }
}

extension on SavedRecipeRow {
  SavedRecipeModel toModel() {
    return SavedRecipeModel(
      id: id,
      title: title,
      cookTimeMinutes: cookTimeMinutes,
      mood: mood,
      rating: rating,
      savedAt: savedAt,
    );
  }
}
