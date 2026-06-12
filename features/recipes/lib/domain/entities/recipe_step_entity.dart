import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'recipe_step_entity.freezed.dart';

/// A single ordered cooking step.
///
/// [timerSeconds] is set for a timed action (e.g. "simmer 10 min" = 600) and is
/// null/zero for an untimed instruction, which drives whether the step renders
/// a countdown timer.
@freezed
abstract class RecipeStepEntity with _$RecipeStepEntity {
  factory RecipeStepEntity({
    required int stepNumber,
    required String instruction,
    int? timerSeconds,
  }) = _RecipeStepEntity;
}
