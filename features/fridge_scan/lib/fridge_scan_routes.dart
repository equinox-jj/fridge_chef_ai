import 'package:core/di/di.dart';
import 'package:core/router/app_route.dart';
import 'package:core/router/nav_keys/navigator_keys.dart';
import 'package:dependencies/bloc/bloc.dart';
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
      create: (_) => getIt<HomeBloc>()..add(const HomeEvent.started()),
      child: const HomePage(),
    );
  }
}

class FridgeScanRoute extends GoRouteData with $FridgeScanRoute {
  const FridgeScanRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ScanBloc>(
      create: (_) => getIt<ScanBloc>(),
      child: const ScanPage(),
    );
  }
}

class ScanHistoryRoute extends GoRouteData with $ScanHistoryRoute {
  const ScanHistoryRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ScanHistoryCubit>(
      create: (_) => getIt<ScanHistoryCubit>()..load(),
      child: const ScanHistoryPage(),
    );
  }
}

class IngredientReviewRoute extends GoRouteData with $IngredientReviewRoute {
  const IngredientReviewRoute({required this.$extra});

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
