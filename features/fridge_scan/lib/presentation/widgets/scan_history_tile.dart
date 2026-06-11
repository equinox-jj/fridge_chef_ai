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

/// A single row in the "Recent scans" list: how many ingredients a past scan
/// found and when it ran. Tapping the row triggers [onTap].
class ScanHistoryTile extends StatelessWidget {
  const ScanHistoryTile({
    required this.scan,
    super.key,
    this.onTap,
  });

  final ScanResultEntity scan;
  final VoidCallback? onTap;

  static final DateFormat _whenFormat = DateFormat('MMM d • h:mm a');

  @override
  Widget build(BuildContext context) {
    final int count = scan.ingredients.length;
    final DateTime? scannedAt = scan.scan.scannedAt;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: const BorderRadius.all(AppRadius.brMd),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            border: Border.all(color: AppColors.borderDefault),
            borderRadius: const BorderRadius.all(AppRadius.brMd),
            boxShadow: AppShadows.xs,
          ),
          padding: const EdgeInsets.all(AppSpacing.s3),
          child: Row(
            spacing: AppSpacing.s4,
            children: <Widget>[
              const AppIconTile(icon: Icons.photo_outlined),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
}
