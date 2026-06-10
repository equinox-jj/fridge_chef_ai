import 'package:core/router/app_route.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/onboarding_page.dart';

part 'onboarding_routes.g.dart';

/// Every route owned by the onboarding feature, exposed for app composition.
List<RouteBase> get onboardingRoutes => $appRoutes;

@TypedGoRoute<OnboardingRoute>(
  path: AppRoute.onboardingPath,
  name: AppRoute.onboardingName,
)
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnboardingPage();
  }
}
