import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'ingredient_entity.freezed.dart';

@freezed
abstract class IngredientEntity with _$IngredientEntity {
  factory IngredientEntity({
    String? id,
    String? scanId,
    String? name,
    String? quantity,
    String? unit,
    String? category,
  }) = _IngredientEntity;
}
