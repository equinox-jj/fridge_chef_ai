import 'package:core/router/app_route.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/profile/profile_page.dart';

part 'profile_routes.g.dart';

/// Every route owned by the profile feature, exposed for app composition.
List<RouteBase> get profileRoutes => $appRoutes;

@TypedGoRoute<ProfileRoute>(
  path: AppRoute.profilePath,
  name: AppRoute.profileName,
)
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}
