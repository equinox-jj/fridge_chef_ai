import 'package:core/components/dietary_chips/dietary_preference_chips.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// One onboarding value-prop, used as the data for a [PageView] page.
class OnboardingStep {
  const OnboardingStep({
    required this.icon,
    required this.title,
    required this.body,
    this.isGeminiMoment = false,
    this.isDietarySetup = false,
  });

  final IconData icon;
  final String title;
  final String body;

  /// Renders in AI purple — the design's "Gemini moment" accent.
  final bool isGeminiMoment;

  /// Shows the dietary chip grid below the copy.
  final bool isDietarySetup;
}

/// Renders a single onboarding page: an accented artwork tile, a headline, a
/// supporting line and — on the dietary step — the preference chips.
///
/// Pure presentation; dietary selection is delegated upward via
/// [onDietarySelected] so the cubit stays the single source of truth.
class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    required this.step,
    this.dietarySelected = DietaryPreference.none,
    this.onDietarySelected,
    super.key,
  });

  final OnboardingStep step;
  final DietaryPreference dietarySelected;
  final ValueChanged<DietaryPreference>? onDietarySelected;

  @override
  Widget build(BuildContext context) {
    final Color accent = step.isGeminiMoment ? AppColors.ai : AppColors.primary;

    // Centers when the content fits the viewport, and scrolls instead of
    // overflowing on short screens or large text-scale settings.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const .symmetric(
                  horizontal: AppSpacing.s7,
                  vertical: AppSpacing.s6,
                ),
                child: Column(
                  mainAxisSize: .min,
                  children: <Widget>[
                    _Artwork(
                      icon: step.icon,
                      accent: accent,
                      compact: step.isDietarySetup,
                    ),
                    const SizedBox(height: AppSpacing.s6),
                    Text(
                      step.title,
                      textAlign: .center,
                      style: context.textTheme.displaySmall,
                    ),
                    const SizedBox(height: AppSpacing.s3),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      child: Text(
                        step.body,
                        textAlign: .center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    if (step.isDietarySetup) ...<Widget>[
                      const SizedBox(height: AppSpacing.s6),
                      DietaryPreferenceChips(
                        selected: dietarySelected,
                        onSelected: onDietarySelected ?? (_) {},
                        alignment: .center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The rounded, tinted tile holding the page's icon. [compact] shrinks it on
/// the dietary step to leave room for the chips.
class _Artwork extends StatelessWidget {
  const _Artwork({
    required this.icon,
    required this.accent,
    required this.compact,
  });

  final IconData icon;
  final Color accent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double size = compact ? 96 : 184;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: const .all(AppRadius.brXxl),
        boxShadow: AppShadows.sm,
      ),
      child: Icon(
        icon,
        size: compact ? AppSpacing.s8 : AppSpacing.s11,
        color: accent,
      ),
    );
  }
}
