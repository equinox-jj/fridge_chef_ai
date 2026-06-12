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
    @JsonKey(name: 'mood', includeFromJson: false) String? mood,
    @JsonKey(name: 'ingredients') @Default(<RecipeIngredientModel>[]) List<RecipeIngredientModel> ingredients,
    @JsonKey(name: 'steps') @Default(<RecipeStepModel>[]) List<RecipeStepModel> steps,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);
}
