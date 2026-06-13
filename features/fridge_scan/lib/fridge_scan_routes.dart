import 'package:core/router/app_route.dart';
import 'package:core/router/nav_keys/navigator_keys.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'domain/entities/scan_result_entity.dart';
import 'presentation/pages/home/bloc/home_bloc.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/ingredient_review/cubit/ingredient_review_cubit.dart';
import 'presentation/pages/ingredient_review/ingredient_review_page.dart';
import 'presentation/pages/scan/bloc/scan_bloc.dart';
import 'presentation/pages/scan/scan_page.dart';
import 'presentation/pages/scan_history/cubit/scan_history_cubit.dart';
import 'presentation/pages/scan_history/scan_history_page.dart';

part 'fridge_scan_routes.g.dart';

/// Every route owned by the fridge-scan feature, exposed for app composition.
List<RouteBase> get fridgeScanRoutes => $appRoutes;

@TypedGoRoute<HomeRoute>(
  path: AppRoute.homePath,
  name: AppRoute.homeName,
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<FridgeScanRoute>(
      path: AppRoute.fridgeScanPath,
      name: AppRoute.fridgeScanName,
    ),
    TypedGoRoute<IngredientReviewRoute>(
      path: AppRoute.ingredientReviewPath,
      name: AppRoute.ingredientReviewName,
    ),
    TypedGoRoute<ScanHistoryRoute>(
      path: AppRoute.scanHistoryPath,
      name: AppRoute.scanHistoryName,
    ),
  ],
)
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<HomeBloc>(
      create: (_) => GetIt.I<HomeBloc>()..add(const HomeEvent.started()),
      child: const HomePage(),
    );
  }
}

class FridgeScanRoute extends GoRouteData with $FridgeScanRoute {
  const FridgeScanRoute();

  /// Presents full-screen on the root navigator, above the dashboard shell, so
  /// the camera scan takes the whole screen with no bottom navigation.
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ScanBloc>(
      create: (_) => GetIt.I<ScanBloc>(),
      child: const ScanPage(),
    );
  }
}

/// The full scan-history list, reached from the profile tab. Nested under
/// [HomeRoute] but presents full-screen on the root navigator (above the
/// dashboard shell) so it backs out cleanly to where it was opened from.
class ScanHistoryRoute extends GoRouteData with $ScanHistoryRoute {
  const ScanHistoryRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ScanHistoryCubit>(
      create: (_) => GetIt.I<ScanHistoryCubit>()..load(),
      child: const ScanHistoryPage(),
    );
  }
}

/// Reviews the ingredients of a completed scan. The [ScanResultEntity] is
/// handed over in memory via `$extra` since it is a transient, non-linkable
/// step in the scan flow.
class IngredientReviewRoute extends GoRouteData with $IngredientReviewRoute {
  const IngredientReviewRoute({required this.$extra});

  /// Stays on the root navigator alongside [FridgeScanRoute] — the scan page
  /// `pushReplacement`s into review, so both must share the same (root)
  /// navigator for the full-screen flow to remain coherent and for backing out
  /// of review to return home rather than under the shell.
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final ScanResultEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<IngredientReviewCubit>(
      create: (_) => IngredientReviewCubit(
        initialItems: $extra.ingredients,
        scanId: $extra.scan.id,
      ),
      child: const IngredientReviewPage(),
    );
  }
}
