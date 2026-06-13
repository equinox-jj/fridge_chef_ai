import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/section_header/app_section_header.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/ingredient_entity.dart';
import '../../../domain/entities/scan_entity.dart';
import '../../../domain/entities/scan_result_entity.dart';
import '../../../fridge_scan_routes.dart';
import '../../widgets/home_greeting.dart';
import '../../widgets/scan_fridge_card.dart';
import '../../widgets/scan_history_tile.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Opens the scan flow, then refreshes recent scans on return so a freshly
  /// completed scan shows up without a manual reload.
  Future<void> _startScan(BuildContext context) async {
    final HomeBloc bloc = context.read<HomeBloc>();
    await const FridgeScanRoute().push<void>(context);
    if (context.mounted) bloc.add(const HomeEvent.refreshed());
  }

  void _openScan(BuildContext context, ScanResultEntity scan) {
    IngredientReviewRoute($extra: scan).push<void>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.s4,
        title: Text(
          'FridgeScan',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: AppSpacing.s2),
        ],
      ),
      floatingActionButton: _ScanFab(
        enabled: true,
        onPressed: () => _startScan(context),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              // Extra bottom padding keeps the last row clear of the FAB.
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s5,
                AppSpacing.s2,
                AppSpacing.s5,
                AppSpacing.s12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.s6,
                children: <Widget>[
                  HomeGreeting(name: state.userProfile?.name),
                  ScanFridgeCard(onTap: () => _startScan(context)),
                  _RecentScansSection(
                    scans: state.recentScans,
                    status: state.recentScansStatus,
                    onTapScan: (ScanResultEntity scan) => _openScan(context, scan),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// "Recent scans" heading plus the list of past scans — skeletons while
/// loading, the rows once loaded, or a friendly empty state when the user
/// hasn't scanned anything yet.
class _RecentScansSection extends StatelessWidget {
  const _RecentScansSection({
    required this.scans,
    required this.status,
    required this.onTapScan,
  });

  final List<ScanResultEntity> scans;
  final BlocStatus status;
  final ValueChanged<ScanResultEntity> onTapScan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s3,
      children: <Widget>[
        const AppSectionHeader(title: 'Recent scans'),
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    switch (status) {
      case BlocStatus.loading:
      case BlocStatus.initial:
        return const _RecentScansSkeleton();
      case BlocStatus.empty:
      case BlocStatus.error:
        return const _EmptyRecentScans();
      case BlocStatus.success:
        if (scans.isEmpty) return const _EmptyRecentScans();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.s3,
          children: <Widget>[
            for (final ScanResultEntity scan in scans)
              ScanHistoryTile(
                scan: scan,
                onTap: () => onTapScan(scan),
              ),
          ],
        );
    }
  }
}

/// Shimmering placeholder rows shown while the recent scans load.
class _RecentScansSkeleton extends StatelessWidget {
  const _RecentScansSkeleton();

  /// A throwaway scan used purely to size the skeleton rows; never shown with
  /// real values because [Skeletonizer] paints over it.
  static final ScanResultEntity _placeholder = ScanResultEntity(
    scan: ScanEntity(scannedAt: DateTime(2026)),
    ingredients: List<IngredientEntity>.filled(5, IngredientEntity()),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s3,
        children: <Widget>[
          for (int i = 0; i < 3; i++) ScanHistoryTile(scan: _placeholder),
        ],
      ),
    );
  }
}

class _EmptyRecentScans extends StatelessWidget {
  const _EmptyRecentScans();

  @override
  Widget build(BuildContext context) {
    return const AppEmptyState(
      icon: Icons.history_rounded,
      title: 'No scans yet',
      message: 'Scan your fridge to see your results here.',
    );
  }
}

class _ScanFab extends StatelessWidget {
  const _ScanFab({
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[AppPalette.green500, AppPalette.green700],
          ),
          boxShadow: enabled ? AppShadows.primary : null,
        ),
        child: FloatingActionButton(
          heroTag: 'home_scan_fab',
          onPressed: enabled ? onPressed : null,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          highlightElevation: 0,
          tooltip: 'Scan your fridge',
          shape: const CircleBorder(),
          child: const Icon(Icons.photo_camera_rounded, size: AppTextSize.h1),
        ),
      ),
    );
  }
}
