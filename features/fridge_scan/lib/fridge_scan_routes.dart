import 'package:core/router/app_route.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/scan/bloc/scan_bloc.dart';
import 'presentation/pages/scan/scan_page.dart';

part 'fridge_scan_routes.g.dart';

/// Every route owned by the fridge-scan feature, exposed for app composition.
List<RouteBase> get fridgeScanRoutes => $appRoutes;

@TypedGoRoute<FridgeScanRoute>(
  path: AppRoute.fridgeScanPath,
  name: AppRoute.fridgeScanName,
)
class FridgeScanRoute extends GoRouteData with $FridgeScanRoute {
  const FridgeScanRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ScanBloc>(
      create: (_) => GetIt.instance<ScanBloc>(),
      child: const ScanPage(),
    );
  }
}
