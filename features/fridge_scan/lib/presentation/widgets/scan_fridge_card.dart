import 'package:core/components/icon_tile/app_icon_tile.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// The dominant call-to-action on the home screen: a soft green gradient card
/// inviting the user to scan their fridge. Tapping it triggers [onTap].
class ScanFridgeCard extends StatelessWidget {
  const ScanFridgeCard({
    required this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  static const BorderRadius _radius = .all(AppRadius.brLg);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap != null ? 1.0 : 0.4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: .topRight,
            end: .bottomLeft,
            colors: <Color>[AppDarkPalette.green50, AppColors.surfaceCard],
          ),
          border: .all(color: AppDarkPalette.green100),
          borderRadius: _radius,
          boxShadow: AppShadows.sm,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: _radius,
            onTap: onTap,
            child: Padding(
              padding: const .all(AppSpacing.s4),
              child: Row(
                spacing: AppSpacing.s4,
                children: <Widget>[
                  const AppIconTile(
                    icon: Icons.photo_camera_rounded,
                    size: 50,
                    borderRadius: .all(AppRadius.brMd),
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    boxShadow: AppShadows.primary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: AppSpacing.s1,
                      children: <Widget>[
                        Text(
                          'Scan your fridge',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                        Text(
                          'Snap a photo to find recipes',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textFaint,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
