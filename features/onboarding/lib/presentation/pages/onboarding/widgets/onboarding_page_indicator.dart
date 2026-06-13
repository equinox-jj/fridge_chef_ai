import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_motion.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// The row of progress dots beneath the onboarding pages: the [activeIndex] dot
/// stretches into a primary pill, the rest stay small and muted.
class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    required this.count,
    required this.activeIndex,
    super.key,
  });

  final int count;
  final int activeIndex;

  static const double _dotSize = AppSpacing.s2;
  static const double _activeWidth = 22;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, (int index) {
        final bool isActive = index == activeIndex;
        return AnimatedContainer(
          duration: AppMotion.base,
          curve: AppMotion.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s1 / 2),
          width: isActive ? _activeWidth : _dotSize,
          height: _dotSize,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.borderPrimary,
            borderRadius: const BorderRadius.all(AppRadius.brFull),
          ),
        );
      }),
    );
  }
}
