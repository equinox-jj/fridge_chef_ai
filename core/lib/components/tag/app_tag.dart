import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Accent palette for [AppTag], mapped to the product's semantic colors.
enum AppTagTone {
  green,
  purple,
  amber,
  coral,
  blue,
  neutral,
}

/// A small pill badge with an optional leading [icon] — e.g. the green
/// "7 found" count on the ingredient screen or a mood badge on a recipe card.
///
/// Tone-driven so the same component covers every accent in the system; the
/// fill, border and text color all derive from the chosen [AppTagTone].
class AppTag extends StatelessWidget {
  const AppTag({
    required this.label,
    super.key,
    this.icon,
    this.tone = AppTagTone.neutral,
  });

  final String label;
  final IconData? icon;
  final AppTagTone tone;

  @override
  Widget build(BuildContext context) {
    final _TagColors colors = _colorsFor(tone);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const .all(AppRadius.brFull),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: AppTextSize.sm, color: colors.foreground),
            const SizedBox(width: AppSpacing.s1),
          ],
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: colors.foreground,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _TagColors _colorsFor(AppTagTone tone) {
    switch (tone) {
      case AppTagTone.green:
        return const _TagColors(
          AppColors.successTint,
          AppDarkPalette.green100,
          AppColors.primaryText,
        );
      case AppTagTone.purple:
        return const _TagColors(
          AppColors.aiTint,
          AppDarkPalette.purple100,
          AppColors.aiText,
        );
      case AppTagTone.amber:
        return const _TagColors(
          AppColors.actionTint,
          AppDarkPalette.amber100,
          AppColors.actionText,
        );
      case AppTagTone.coral:
        return const _TagColors(
          AppColors.dangerTint,
          AppDarkPalette.coral100,
          AppColors.dangerText,
        );
      case AppTagTone.blue:
        return const _TagColors(
          AppColors.infoTint,
          AppDarkPalette.blue100,
          AppColors.infoText,
        );
      case AppTagTone.neutral:
        return const _TagColors(
          AppColors.surfaceSunken,
          AppColors.borderDefault,
          AppColors.textBody,
        );
    }
  }
}

/// Resolved fill/border/text triple for a given [AppTagTone].
class _TagColors {
  const _TagColors(this.background, this.border, this.foreground);

  final Color background;
  final Color border;
  final Color foreground;
}
