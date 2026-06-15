import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient_model.freezed.dart';
part 'recipe_ingredient_model.g.dart';

@freezed
abstract class RecipeIngredientModel with _$RecipeIngredientModel {
  factory RecipeIngredientModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'quantity') String? quantity,
    @JsonKey(name: 'unit') String? unit,
    @JsonKey(name: 'is_substitute') @Default(false) bool isSubstitute,
  }) = _RecipeIngredientModel;

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientModelFromJson(json);
}
