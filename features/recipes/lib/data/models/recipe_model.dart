import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import 'recipe_ingredient_model.dart';
import 'recipe_step_model.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

/// Data-layer recipe, deserialised from the Gemini generation response.
///
/// [mood] is not part of the model's JSON (it is a generation *input*); it is
/// attached by the data source after parsing so a generated recipe still
/// carries the mood it was tuned for.
@freezed
abstract class RecipeModel with _$RecipeModel {
  factory RecipeModel({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'servings') int? servings,
    @JsonKey(name: 'cook_time_minutes') int? cookTimeMinutes,
    // `mood` is a generation *input*, not part of the model's response JSON, so
    // it's excluded from fromJson. It IS written to toJson, though, so the
    // detail cache (which persists toJson and re-reads it) keeps the mood.
    @JsonKey(name: 'mood', includeFromJson: false, includeToJson: true)
    String? mood,
    @JsonKey(name: 'ingredients')
    @Default(<RecipeIngredientModel>[])
    List<RecipeIngredientModel> ingredients,
    @JsonKey(name: 'steps')
    @Default(<RecipeStepModel>[])
    List<RecipeStepModel> steps,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  /// Builds a full recipe from a `recipes` row with its embedded
  /// `recipe_steps` and `recipe_ingredients`, as returned by the detail query.
  ///
  /// The backend nests the steps and ingredients under their table names and
  /// (unlike the generation JSON) carries `mood` as a real column, so this
  /// flattens the row explicitly rather than reusing [fromJson]. Steps and
  /// ingredients reuse their own `fromJson` since their column names match.
  factory RecipeModel.fromSupabaseRow(Map<String, dynamic> row) {
    final List<dynamic> steps =
        (row['recipe_steps'] as List<dynamic>?) ?? const <dynamic>[];
    final List<dynamic> ingredients =
        (row['recipe_ingredients'] as List<dynamic>?) ?? const <dynamic>[];
    return RecipeModel(
      title: row['title'] as String?,
      description: row['description'] as String?,
      servings: row['servings'] as int?,
      cookTimeMinutes: row['cook_time_minutes'] as int?,
      mood: row['mood'] as String?,
      steps: steps
          .map(
            (dynamic e) => RecipeStepModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      ingredients: ingredients
          .map(
            (dynamic e) =>
                RecipeIngredientModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
