import 'package:core/components/step_timer/app_step_timer.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/recipe_step_entity.dart';

/// One numbered cooking step. Steps with a positive `timerSeconds` render an
/// [AppStepTimer] beneath the instruction (PRD §4.3.4).
class RecipeStepTile extends StatelessWidget {
  const RecipeStepTile({
    required this.step,
    super.key,
  });

  final RecipeStepEntity step;

  bool get _hasTimer => (step.timerSeconds ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s3,
      ),
      child: Row(
        crossAxisAlignment: .start,
        spacing: AppSpacing.s4,
        children: <Widget>[
          _StepNumber(number: step.stepNumber),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                Text(
                  step.instruction,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
                if (_hasTimer) ...<Widget>[
                  const SizedBox(height: AppSpacing.s3),
                  AppStepTimer(seconds: step.timerSeconds!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The green numbered badge to the left of a step.
class _StepNumber extends StatelessWidget {
  const _StepNumber({required this.number});

  static const double _size = 30;

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      alignment: .center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: .circle,
      ),
      child: Text(
        '$number',
        style: AppTypography.mono.copyWith(
          fontSize: AppTextSize.sm,
          fontWeight: AppFontWeight.bold,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }
}
