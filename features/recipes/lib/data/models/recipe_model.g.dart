// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => _RecipeModel(
  title: json['title'] as String?,
  description: json['description'] as String?,
  servings: (json['servings'] as num?)?.toInt(),
  cookTimeMinutes: (json['cook_time_minutes'] as num?)?.toInt(),
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map(
            (e) => RecipeIngredientModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <RecipeIngredientModel>[],
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => RecipeStepModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RecipeStepModel>[],
);

Map<String, dynamic> _$RecipeModelToJson(_RecipeModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'servings': instance.servings,
      'cook_time_minutes': instance.cookTimeMinutes,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
    };
