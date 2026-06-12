// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeIngredientModel _$RecipeIngredientModelFromJson(
  Map<String, dynamic> json,
) => _RecipeIngredientModel(
  name: json['name'] as String?,
  quantity: json['quantity'] as String?,
  unit: json['unit'] as String?,
  isSubstitute: json['is_substitute'] as bool? ?? false,
);

Map<String, dynamic> _$RecipeIngredientModelToJson(
  _RecipeIngredientModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'quantity': instance.quantity,
  'unit': instance.unit,
  'is_substitute': instance.isSubstitute,
};
