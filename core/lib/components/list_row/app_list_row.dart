import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../icon_tile/app_icon_tile.dart';

/// Accent tones an [AppListRow]'s leading icon tile can take, mapped to the
/// product's semantic colors.
enum AppListRowTone { primary, blue, coral }

/// A tappable settings/menu row: a tinted leading [icon], a [title], an optional
/// trailing [value], and (by default) a chevron — the design system's `ListRow`.
///
/// Used to build grouped option lists (e.g. the profile's Preferences and
/// Account sections). Set [isDestructive] for a coral, destructive row such as
/// "Sign out". The leading tile's colors derive from [tone].
class AppListRow extends StatelessWidget {
  const AppListRow({
    required this.icon,
    required this.title,
    super.key,
    this.value,
    this.tone = AppListRowTone.primary,
    this.showChevron = true,
    this.isDestructive = false,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;

  /// Trailing summary text shown before the chevron (e.g. "Vegetarian").
  final String? value;
  final AppListRowTone tone;
  final bool showChevron;

  /// Renders the title and leading glyph in the danger (coral) color.
  final bool isDestructive;
  final VoidCallback? onTap;

  /// Optional trailing widget (e.g. a [Switch]). When provided it replaces the
  /// [value] text and the chevron.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final _ToneColors colors = isDestructive
        ? const _ToneColors(
            AppColors.dangerTint,
            AppColors.danger,
          )
        : _colorsFor(tone);
    final Color titleColor = isDestructive
        ? AppColors.dangerText
        : AppColors.textStrong;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: AppSpacing.s3,
          ),
          child: Row(
            spacing: AppSpacing.s4,
            children: <Widget>[
              AppIconTile(
                icon: icon,
                size: AppSpacing.s9,
                backgroundColor: colors.background,
                foregroundColor: colors.foreground,
              ),
              if (trailing != null)
                trailing!
              else
                Expanded(
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    spacing: 10,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 2,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: titleColor,
                          overflow: .ellipsis,
                        ),
                      ),
                      if (value != null)
                        Flexible(
                          child: Text(
                            value!,
                            textAlign: .end,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textMuted,
                              overflow: .ellipsis,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              if (showChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textFaint,
                ),
            ],
          ),
        ),
      ),
    );
  }

  _ToneColors _colorsFor(AppListRowTone tone) {
    switch (tone) {
      case AppListRowTone.primary:
        return const _ToneColors(AppColors.primaryTint, AppColors.primary);
      case AppListRowTone.blue:
        return const _ToneColors(AppColors.infoTint, AppColors.info);
      case AppListRowTone.coral:
        return const _ToneColors(AppColors.dangerTint, AppColors.danger);
    }
  }
}

/// Resolved background/foreground pair for an [AppListRow]'s leading tile.
class _ToneColors {
  const _ToneColors(this.background, this.foreground);

  final Color background;
  final Color foreground;
}
