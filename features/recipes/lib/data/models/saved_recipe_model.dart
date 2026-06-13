import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'saved_recipe_model.freezed.dart';

/// Data-layer view of a cookbook entry, shared by both data sources: built from
/// a Supabase `saved_recipes`→`recipes` join and from a cached Drift row.
///
/// JSON isn't generated for it — the remote shape is a nested join row rather
/// than a flat object, so [SavedRecipeModel.fromSupabaseRow] flattens it
/// explicitly, which is clearer than wrangling annotations for the nesting.
@freezed
abstract class SavedRecipeModel with _$SavedRecipeModel {
  factory SavedRecipeModel({
    required String id,
    required String title,
    required DateTime savedAt,
    int? cookTimeMinutes,
    String? mood,
    @Default(0) int rating,
  }) = _SavedRecipeModel;

  /// Flattens a `saved_recipes` row with its embedded `recipes` record, as
  /// returned by `select('rating, saved_at, recipes(id, title,
  /// cook_time_minutes, mood)')`.
  factory SavedRecipeModel.fromSupabaseRow(Map<String, dynamic> row) {
    final Map<String, dynamic> recipe = (row['recipes'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    return SavedRecipeModel(
      id: recipe['id'] as String,
      title: (recipe['title'] as String?) ?? 'Untitled recipe',
      cookTimeMinutes: recipe['cook_time_minutes'] as int?,
      mood: recipe['mood'] as String?,
      rating: (row['rating'] as int?) ?? 0,
      savedAt: DateTime.parse(row['saved_at'] as String),
    );
  }
}
