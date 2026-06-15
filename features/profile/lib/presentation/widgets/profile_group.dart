import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// A titled group of settings rows: an uppercase eyebrow [label] above a
/// rounded card that stacks [rows] with hairline dividers between them
/// (design 4.1's Preferences / Account sections).
///
/// Feature-local layout — it composes core's `AppListRow`s into the profile's
/// grouped-list look rather than introducing a new globally-shared primitive.
class ProfileGroup extends StatelessWidget {
  const ProfileGroup({
    required this.label,
    required this.rows,
    super.key,
  });

  final String label;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.s1,
            bottom: AppSpacing.s2,
          ),
          child: Text(
            label.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textMuted,
              fontWeight: AppFontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            border: Border.all(color: AppColors.borderDefault),
            borderRadius: const .all(AppRadius.brLg),
            boxShadow: AppShadows.xs,
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < rows.length; i++) ...<Widget>[
                if (i > 0)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.borderSubtle,
                  ),
                rows[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
