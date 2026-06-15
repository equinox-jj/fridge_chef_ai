import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import 'recipe_ingredient_entity.dart';
import 'recipe_step_entity.dart';

part 'recipe_entity.freezed.dart';

/// An AI-generated recipe: a header plus its ingredients and ordered steps.
///
/// [id] is null until the recipe is saved (it is assigned by the database on
/// insert). [mood] is the mood the recipe was generated for, kept on the
/// entity so it can be shown as a badge and persisted with the saved recipe.
@freezed
abstract class RecipeEntity with _$RecipeEntity {
  factory RecipeEntity({
    required String title,
    String? id,
    String? description,
    int? servings,
    int? cookTimeMinutes,
    String? mood,
    @Default(<RecipeIngredientEntity>[])
    List<RecipeIngredientEntity> ingredients,
    @Default(<RecipeStepEntity>[]) List<RecipeStepEntity> steps,
  }) = _RecipeEntity;
}
