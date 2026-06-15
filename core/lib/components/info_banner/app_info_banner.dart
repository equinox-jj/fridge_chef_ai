import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Semantic colour for an [AppInfoBanner].
enum AppInfoBannerTone {
  info(
    AppColors.infoTint,
    AppColors.infoText,
    Icons.info_outline_rounded,
  ),
  warning(
    AppColors.actionTint,
    AppColors.actionText,
    Icons.warning_amber_rounded,
  ),
  danger(
    AppColors.dangerTint,
    AppColors.dangerText,
    Icons.error_outline_rounded,
  );

  const AppInfoBannerTone(
    this.background,
    this.foreground,
    this.defaultIcon,
  );

  final Color background;
  final Color foreground;
  final IconData defaultIcon;
}

/// A tinted, single-line status banner: a leading [icon] beside a [message].
///
/// Shared across the app for inline, non-blocking status (you're offline, a
/// soft warning, …) so these notices read the same everywhere. The [tone] sets
/// the colour and a sensible default icon; pass [icon] to override it.
class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({
    required this.message,
    super.key,
    this.tone = AppInfoBannerTone.info,
    this.icon,
  });

  final String message;
  final AppInfoBannerTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: tone.background,
        borderRadius: const .all(AppRadius.brMd),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon ?? tone.defaultIcon,
            size: AppTextSize.lg,
            color: tone.foreground,
          ),
          const SizedBox(width: AppSpacing.s2),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.bodySmall?.copyWith(
                color: tone.foreground,
                fontWeight: AppFontWeight.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
