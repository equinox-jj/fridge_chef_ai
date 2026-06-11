// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IngredientModel _$IngredientModelFromJson(Map<String, dynamic> json) => _IngredientModel(
  id: json['id'] as String?,
  scanId: json['scan_id'] as String?,
  name: json['name'] as String?,
  quantity: json['quantity'] as String?,
  unit: json['unit'] as String?,
  category: json['category'] as String?,
);

Map<String, dynamic> _$IngredientModelToJson(_IngredientModel instance) => <String, dynamic>{
  'id': instance.id,
  'scan_id': instance.scanId,
  'name': instance.name,
  'quantity': instance.quantity,
  'unit': instance.unit,
  'category': instance.category,
};
