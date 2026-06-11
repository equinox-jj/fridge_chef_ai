import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
abstract class IngredientModel with _$IngredientModel {
  factory IngredientModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'scan_id') String? scanId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'quantity') String? quantity,
    @JsonKey(name: 'unit') String? unit,
    @JsonKey(name: 'category') String? category,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);
}
