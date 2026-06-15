import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/tag/app_tag.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/ingredient_entity.dart';
import '../../../domain/entities/scan_entity.dart';
import '../../../domain/entities/scan_result_entity.dart';
import '../../../fridge_scan_routes.dart';
import '../../widgets/scan_history_tile.dart';
import 'cubit/scan_history_cubit.dart';

/// The full scan-history screen (design 4.3 / 4.4): every past fridge scan,
/// newest first. Tapping a scan reopens its ingredients to cook again; the
/// empty state invites a first scan.
class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  /// Reopens a past scan's ingredients — closing the loop back into recipes.
  void _openScan(BuildContext context, ScanResultEntity scan) {
    IngredientReviewRoute($extra: scan).push<void>(context);
  }

  void _startScan(BuildContext context) {
    const FridgeScanRoute().push<void>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan history',
          style: context.textTheme.headlineSmall?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        actions: <Widget>[
          BlocBuilder<ScanHistoryCubit, ScanHistoryState>(
            buildWhen: (ScanHistoryState p, ScanHistoryState c) =>
                p.scans.length != c.scans.length,
            builder: (BuildContext context, ScanHistoryState state) {
              if (state.scans.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.s4),
                child: AppTag(
                  tone: AppTagTone.blue,
                  icon: Icons.history_rounded,
                  label: '${state.scans.length} scans',
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ScanHistoryCubit, ScanHistoryState>(
        builder: (BuildContext context, ScanHistoryState state) {
          return switch (state.status) {
            BlocStatus.loading ||
            BlocStatus.initial => const _ScanHistorySkeleton(),
            BlocStatus.empty || BlocStatus.error => _ScanHistoryEmpty(
              onScan: () => _startScan(context),
            ),
            BlocStatus.success => _ScanHistoryList(
              scans: state.scans,
              onTapScan: (ScanResultEntity scan) => _openScan(context, scan),
            ),
          };
        },
      ),
    );
  }
}

/// The loaded list: an intro line plus one rescan-able row per past scan.
class _ScanHistoryList extends StatelessWidget {
  const _ScanHistoryList({
    required this.scans,
    required this.onTapScan,
  });

  final List<ScanResultEntity> scans;
  final ValueChanged<ScanResultEntity> onTapScan;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s5,
        AppSpacing.s2,
        AppSpacing.s5,
        AppSpacing.s8,
      ),
      itemCount: scans.length + 1,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.s3),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s1),
            child: Text(
              'Tap a scan to reopen its ingredients and cook again.',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          );
        }
        final ScanResultEntity scan = scans[index - 1];
        return ScanHistoryTile(
          scan: scan,
          trailingIcon: Icons.refresh_rounded,
          trailingColor: AppColors.primary,
          onTap: () => onTapScan(scan),
        );
      },
    );
  }
}

/// Shimmering placeholder rows shown while the history loads.
class _ScanHistorySkeleton extends StatelessWidget {
  const _ScanHistorySkeleton();

  /// A throwaway scan used purely to size the skeleton rows; never shown with
  /// real values because [Skeletonizer] paints over it.
  static final ScanResultEntity _placeholder = ScanResultEntity(
    scan: ScanEntity(scannedAt: DateTime(2026)),
    ingredients: List<IngredientEntity>.filled(5, IngredientEntity()),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s5,
          AppSpacing.s4,
          AppSpacing.s5,
          AppSpacing.s8,
        ),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.s3),
        itemBuilder: (_, _) => ScanHistoryTile(scan: _placeholder),
      ),
    );
  }
}

/// Empty state (design 4.4): no scans yet, with a prompt to start one.
class _ScanHistoryEmpty extends StatelessWidget {
  const _ScanHistoryEmpty({required this.onScan});

  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppEmptyState(
        icon: Icons.photo_camera_rounded,
        title: 'No scans yet',
        message: 'Point your camera at the fridge to get started.',
        actionLabel: 'Scan your fridge',
        actionIcon: Icons.photo_camera_rounded,
        onAction: onScan,
      ),
    );
  }
}
