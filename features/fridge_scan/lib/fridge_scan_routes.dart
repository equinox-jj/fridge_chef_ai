import 'package:core/router/app_route.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/home/bloc/home_bloc.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/scan/bloc/scan_bloc.dart';
import 'presentation/pages/scan/scan_page.dart';

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

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ScanBloc>(
      create: (_) => GetIt.I<ScanBloc>(),
      child: const ScanPage(),
    );
  }
}
