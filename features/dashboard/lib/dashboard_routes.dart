import 'package:core/router/app_route.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/dashboard/dashboard_page.dart';

part 'dashboard_routes.g.dart';

/// Every route owned by the dashboard feature, exposed for app composition.
List<RouteBase> get dashboardRoutes => $appRoutes;

@TypedGoRoute<DashboardRoute>(
  path: AppRoute.dashboardPath,
  name: AppRoute.dashboardName,
)
class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardPage();
  }
}
