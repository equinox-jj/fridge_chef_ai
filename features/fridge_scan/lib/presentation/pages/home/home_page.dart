import 'package:core/blocs/connectivity_bloc.dart';
import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/section_header/app_section_header.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_motion.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/entities/ingredient_entity.dart';
import '../../../domain/entities/scan_entity.dart';
import '../../../domain/entities/scan_result_entity.dart';
import '../../../fridge_scan_routes.dart';
import '../../widgets/home_greeting.dart';
import '../../widgets/scan_fridge_card.dart';
import '../../widgets/scan_history_tile.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Drives the FAB's hide-on-scroll-down / show-on-scroll-up animation. A
  /// [ValueNotifier] keeps the rebuild scoped to the FAB alone, so scrolling
  /// never rebuilds the page body.
  final ValueNotifier<bool> _fabVisible = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _fabVisible.dispose();
    super.dispose();
  }

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

  /// Reloads recent scans and keeps the pull-to-refresh spinner alive until the
  /// load settles (leaves [BlocStatus.loading]).
  Future<void> _refresh() async {
    final HomeBloc bloc = context.read<HomeBloc>();
    bloc.add(const HomeEvent.refreshed());
    await bloc.stream.firstWhere(
      (HomeState state) => state.recentScansStatus != BlocStatus.loading,
    );
  }

  /// Shows the FAB when the user scrolls up and hides it when scrolling down.
  /// The [ValueNotifier] only notifies on an actual flip, so a held scroll in
  /// one direction is a no-op after the first frame.
  bool _onScroll(UserScrollNotification notification) {
    // Only the primary vertical scroll view drives this — ignore any nested or
    // horizontal scrollables.
    if (notification.depth != 0) return false;
    switch (notification.direction) {
      case ScrollDirection.reverse:
        _fabVisible.value = false;
      case ScrollDirection.forward:
        _fabVisible.value = true;
      case ScrollDirection.idle:
        break;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Scanning needs a connection for AI generation, so the FAB is disabled
    // offline — mirroring the Cookbook tab. Offline is read from the app-wide
    // ConnectivityBloc.
    final bool isOffline = context.watch<ConnectivityBloc>().state.isOffline;
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
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _fabVisible,
        // The FAB itself is built once and reused across visibility flips.
        child: _ScanFab(
          enabled: !isOffline,
          onPressed: () => _startScan(context),
        ),
        builder: (BuildContext context, bool visible, Widget? child) {
          // Slide off-screen (also removes it from the hit-test area) and fade.
          return AnimatedSlide(
            duration: AppMotion.base,
            curve: AppMotion.easeOut,
            offset: visible ? Offset.zero : const Offset(0, 2),
            child: AnimatedOpacity(
              duration: AppMotion.base,
              curve: AppMotion.easeOut,
              opacity: visible ? 1 : 0,
              child: child,
            ),
          );
        },
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: _onScroll,
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, HomeState state) {
              return SafeArea(
                top: false,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: <Widget>[
                    // Fixed-height top content + the "Recent scans" heading.
                    SliverPadding(
                      padding: const .fromLTRB(
                        AppSpacing.s5,
                        AppSpacing.s2,
                        AppSpacing.s5,
                        0,
                      ),
                      sliver: SliverList.list(
                        children: <Widget>[
                          HomeGreeting(name: state.userProfile?.name),
                          const SizedBox(height: AppSpacing.s6),
                          ScanFridgeCard(
                            onTap: isOffline ? null : () => _startScan(context),
                          ),
                          const SizedBox(height: AppSpacing.s6),
                          const AppSectionHeader(title: 'Recent scans'),
                          const SizedBox(height: AppSpacing.s3),
                        ],
                      ),
                    ),
                    // The scan rows lazily built as a real sliver list.
                    _RecentScansSliver(
                      scans: state.recentScans,
                      status: state.recentScansStatus,
                      onTapScan: (ScanResultEntity scan) =>
                          _openScan(context, scan),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// The list of past scans as a sliver — skeletons while loading, lazily built
/// rows once loaded, or a friendly empty state when the user hasn't scanned
/// anything yet. The "Recent scans" heading lives in the page's top sliver.
class _RecentScansSliver extends StatelessWidget {
  const _RecentScansSliver({
    required this.scans,
    required this.status,
    required this.onTapScan,
  });

  /// Horizontal page gutter plus the bottom inset that clears the FAB.
  static const EdgeInsets _padding = .fromLTRB(
    AppSpacing.s5,
    0,
    AppSpacing.s5,
    AppSpacing.s12,
  );

  final List<ScanResultEntity> scans;
  final BlocStatus status;
  final ValueChanged<ScanResultEntity> onTapScan;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case BlocStatus.loading:
        return const SliverPadding(
          padding: _padding,
          sliver: SliverToBoxAdapter(
            child: _RecentScansSkeleton(),
          ),
        );
      case BlocStatus.initial:
      case BlocStatus.empty:
      case BlocStatus.error:
        return const _EmptyRecentScansSliver();
      case BlocStatus.success:
        if (scans.isEmpty) return const _EmptyRecentScansSliver();
        return SliverPadding(
          padding: _padding,
          sliver: SliverList.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              final ScanResultEntity scan = scans[index];
              return Padding(
                // Gap between rows; skip it after the last one.
                padding: .only(
                  bottom: index == scans.length - 1 ? 0 : AppSpacing.s3,
                ),
                child: ScanHistoryTile(
                  scan: scan,
                  onTap: () => onTapScan(scan),
                ),
              );
            },
          ),
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
        crossAxisAlignment: .stretch,
        spacing: AppSpacing.s3,
        children: <Widget>[
          for (int i = 0; i < 3; i++) ScanHistoryTile(scan: _placeholder),
        ],
      ),
    );
  }
}

/// Empty state that fills the remaining viewport so it sits centred below the
/// header instead of hugging it, and still stretches enough to pull-to-refresh.
class _EmptyRecentScansSliver extends StatelessWidget {
  const _EmptyRecentScansSliver();

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: .fromLTRB(
        AppSpacing.s5,
        0,
        AppSpacing.s5,
        AppSpacing.s12,
      ),
      sliver: SliverFillRemaining(
        hasScrollBody: false,
        child: AppEmptyState(
          icon: Icons.history_rounded,
          title: 'No scans yet',
          message: 'Scan your fridge to see your results here.',
        ),
      ),
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
          shape: .circle,
          gradient: const LinearGradient(
            begin: .topLeft,
            end: .bottomRight,
            colors: <Color>[
              AppPalette.green500,
              AppPalette.green700,
            ],
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
          child: const Icon(
            Icons.photo_camera_rounded,
            size: AppTextSize.h1,
          ),
        ),
      ),
    );
  }
}
