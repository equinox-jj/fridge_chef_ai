// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeStepModel _$RecipeStepModelFromJson(Map<String, dynamic> json) =>
    _RecipeStepModel(
      stepNumber: (json['step_number'] as num?)?.toInt(),
      instruction: json['instruction'] as String?,
      timerSeconds: (json['timer_seconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecipeStepModelToJson(_RecipeStepModel instance) =>
    <String, dynamic>{
      'step_number': instance.stepNumber,
      'instruction': instance.instruction,
      'timer_seconds': instance.timerSeconds,
    };
