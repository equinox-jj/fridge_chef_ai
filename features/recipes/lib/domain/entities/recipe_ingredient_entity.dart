import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient_entity.freezed.dart';

/// One ingredient line in a recipe.
///
/// [isSubstitute] marks an item the model suggested in place of something the
/// user did not have, so the UI can flag it distinctly (PRD §4.3.4).
@freezed
abstract class RecipeIngredientEntity with _$RecipeIngredientEntity {
  factory RecipeIngredientEntity({
    String? name,
    String? quantity,
    String? unit,
    @Default(false) bool isSubstitute,
  }) = _RecipeIngredientEntity;
}
