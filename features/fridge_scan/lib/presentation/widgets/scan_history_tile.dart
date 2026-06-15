import 'package:core/components/icon_tile/app_icon_tile.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/intl/intl.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/scan_result_entity.dart';

/// A single row in a scan list: how many ingredients a past scan found and when
/// it ran. Tapping the row triggers [onTap].
///
/// [trailingIcon] and [trailingColor] decorate the trailing affordance — a
/// chevron on the home preview, the green "rescan" loop glyph on the full
/// scan-history screen where a tap reopens the scan to cook again.
class ScanHistoryTile extends StatelessWidget {
  const ScanHistoryTile({
    required this.scan,
    super.key,
    this.onTap,
    this.trailingIcon = Icons.chevron_right_rounded,
    this.trailingColor = AppColors.textFaint,
  });

  final ScanResultEntity scan;
  final VoidCallback? onTap;
  final IconData trailingIcon;
  final Color trailingColor;

  static final DateFormat _whenFormat = DateFormat('MMM d • h:mm a');

  @override
  Widget build(BuildContext context) {
    final int count = scan.ingredients.length;
    final DateTime? scannedAt = scan.scan.scannedAt;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const .all(AppRadius.brMd),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            border: .all(color: AppColors.borderDefault),
            borderRadius: const .all(AppRadius.brMd),
            boxShadow: AppShadows.xs,
          ),
          padding: const .all(AppSpacing.s3),
          child: Row(
            spacing: AppSpacing.s4,
            children: <Widget>[
              const AppIconTile(icon: Icons.photo_outlined),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: AppSpacing.s1,
                  children: <Widget>[
                    Text(
                      '$count ingredients found',
                      style: context.textTheme.titleMedium,
                    ),
                    if (scannedAt != null)
                      Text(
                        _whenFormat.format(scannedAt),
                        style: AppTypography.mono.copyWith(
                          fontSize: AppTextSize.sm,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                trailingIcon,
                color: trailingColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
