import 'package:core/blocs/connectivity_bloc.dart';
import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/info_banner/app_info_banner.dart';
import 'package:core/components/loader/app_loading_indicator.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_motion.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/entities/saved_recipe_entity.dart';
import '../../../recipes_routes.dart';
import 'bloc/cookbook_bloc.dart';
import 'widgets/cookbook_card.dart';

/// The Cookbook tab: the user's saved recipes, cached on device so the screen
/// works offline (PRD §4.4).
///
/// One page, three states off the same [CookbookBloc] — the populated grid, the
/// empty state, and (when there's no connection) an offline banner over the
/// cached grid with scanning disabled. Offline is framed as a capability, not a
/// failure: the cookbook still opens and reads.
class CookbookPage extends StatefulWidget {
  const CookbookPage({super.key});

  @override
  State<CookbookPage> createState() => _CookbookPageState();
}

class _CookbookPageState extends State<CookbookPage> {
  /// Drives the FAB's hide-on-scroll-down / show-on-scroll-up animation. A
  /// [ValueNotifier] keeps the rebuild scoped to the FAB alone, so scrolling
  /// never rebuilds the grid.
  final ValueNotifier<bool> _fabVisible = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _fabVisible.dispose();
    super.dispose();
  }

  void _startScan() => GetIt.I<AppNavigator>().toHome();

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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.s4,
        title: Text(
          'Cookbook',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<CookbookBloc, CookbookState>(
        buildWhen: (CookbookState p, CookbookState c) => p.status != c.status,
        builder: (BuildContext context, CookbookState state) {
          // The scan shortcut is hidden on the empty state (which has its own
          // CTA) and disabled offline, since AI generation needs a connection.
          // Offline is read from the app-wide ConnectivityBloc.
          if (state.status == BlocStatus.empty) return const SizedBox.shrink();
          final bool isOffline = context.watch<ConnectivityBloc>().state.isOffline;
          return ValueListenableBuilder<bool>(
            valueListenable: _fabVisible,
            // The FAB itself is built once and reused across visibility flips.
            child: _ScanFab(
              enabled: !isOffline,
              onPressed: _startScan,
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
          );
        },
      ),
      body: SafeArea(
        top: false,
        child: NotificationListener<UserScrollNotification>(
          onNotification: _onScroll,
          child: BlocBuilder<CookbookBloc, CookbookState>(
            builder: (BuildContext context, CookbookState state) {
              final bool isOffline = context.watch<ConnectivityBloc>().state.isOffline;
              return Column(
                children: <Widget>[
                  if (isOffline)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.s5,
                        AppSpacing.s2,
                        AppSpacing.s5,
                        0,
                      ),
                      child: AppInfoBanner(
                        message: "You're offline — timers and saved recipes still work.",
                        icon: Icons.wifi_off_rounded,
                      ),
                    ),
                  Expanded(
                    child: _CookbookBody(
                      state: state,
                      onScan: _startScan,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Switches between the loading, error, empty and populated states.
class _CookbookBody extends StatelessWidget {
  const _CookbookBody({
    required this.state,
    required this.onScan,
  });

  final CookbookState state;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case BlocStatus.initial:
      case BlocStatus.loading:
        // The cache read is near-instant; only show a spinner before the first
        // result, never on top of recipes we're already showing.
        if (state.recipes.isEmpty) {
          return const AppLoadingIndicator();
        }
        return _CookbookGrid(recipes: state.recipes);
      case BlocStatus.empty:
        return Center(
          child: AppEmptyState(
            icon: Icons.menu_book_rounded,
            title: 'Your cookbook is empty',
            message: 'Save a recipe and it lands here — ready to cook, even offline.',
            actionLabel: 'Scan your fridge',
            actionIcon: Icons.photo_camera_rounded,
            onAction: onScan,
          ),
        );
      case BlocStatus.error:
        return Center(
          child: AppEmptyState(
            icon: Icons.cloud_off_rounded,
            title: "Couldn't open your cookbook",
            message: state.failure?.message ?? 'Something went wrong. Please try again.',
            actionLabel: 'Try again',
            actionIcon: Icons.refresh_rounded,
            onAction: () => context.read<CookbookBloc>().add(const CookbookEvent.refreshed()),
          ),
        );
      case BlocStatus.success:
        return _CookbookGrid(recipes: state.recipes);
    }
  }
}

/// The two-up grid, led by the mono count line that doubles as the offline
/// promise. Pull-to-refresh re-reads the cookbook.
class _CookbookGrid extends StatelessWidget {
  const _CookbookGrid({required this.recipes});

  final List<SavedRecipeEntity> recipes;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<CookbookBloc>().add(
        const CookbookEvent.refreshed(),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s5,
              AppSpacing.s2,
              AppSpacing.s5,
              AppSpacing.s3,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                '${recipes.length} saved ${recipes.length == 1 ? 'recipe' : 'recipes'} · available offline',
                style: context.textTheme.bodySmall?.copyWith(
                  fontFamily: AppFontFamily.mono,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s5,
              0,
              AppSpacing.s5,
              AppSpacing.s8,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.s3,
                crossAxisSpacing: AppSpacing.s3,
                childAspectRatio: 0.82,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => CookbookCard(
                  recipe: recipes[index],
                  // Open the full recipe by id; it loads cache-first, so a
                  // saved recipe still reads offline once it's been opened.
                  onTap: () => RecipeDetailViewRoute(id: recipes[index].id).push<void>(context),
                ),
                childCount: recipes.length,
              ),
            ),
          ),
        ],
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
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[AppPalette.green500, AppPalette.green700],
          ),
          boxShadow: enabled ? AppShadows.primary : null,
        ),
        child: FloatingActionButton(
          heroTag: 'cookbook_scan_fab',
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
