import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// A compact "− value +" pill for adjusting a discrete amount (ingredient
/// quantity, recipe servings, …).
///
/// Display-only of [label] so callers stay in control of formatting (e.g.
/// "250 g" or "2 pcs"); the +/- buttons just fire [onIncrement] /
/// [onDecrement]. Passing `null` for either callback disables that button.
class AppStepper extends StatelessWidget {
  const AppStepper({
    required this.label,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final String label;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(AppSpacing.s1 - 1),
      decoration: const BoxDecoration(
        color: AppColors.surfaceSunken,
        borderRadius: .all(AppRadius.brFull),
      ),
      child: Row(
        mainAxisSize: .min,
        children: <Widget>[
          _StepButton(
            icon: Icons.remove_rounded,
            onPressed: onDecrement,
            tooltip: 'Decrease',
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 52),
            child: Text(
              label,
              textAlign: .center,
              style: AppTypography.mono.copyWith(
                fontSize: AppTextSize.sm,
                color: AppColors.textBody,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            onPressed: onIncrement,
            tooltip: 'Increase',
          ),
        ],
      ),
    );
  }
}

/// A single round +/- button inside [AppStepper].
class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  static const double _size = 28;

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    return Material(
      color: AppColors.surfaceCard,
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          shape: .circle,
          boxShadow: AppShadows.xs,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: _size,
            height: _size,
            child: Icon(
              icon,
              size: AppTextSize.lg,
              color: enabled ? AppDarkPalette.neutral600 : AppColors.textFaint,
            ),
          ),
        ),
      ),
    );
  }
}
