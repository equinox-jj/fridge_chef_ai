import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'recipe_step_model.freezed.dart';
part 'recipe_step_model.g.dart';

@freezed
abstract class RecipeStepModel with _$RecipeStepModel {
  factory RecipeStepModel({
    @JsonKey(name: 'step_number') int? stepNumber,
    @JsonKey(name: 'instruction') String? instruction,
    @JsonKey(name: 'timer_seconds') int? timerSeconds,
  }) = _RecipeStepModel;

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepModelFromJson(json);
}
