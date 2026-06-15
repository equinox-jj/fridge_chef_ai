import 'package:core/di/di.dart';
import 'package:core/router/app_route.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/onboarding/cubit/onboarding_cubit.dart';
import 'presentation/pages/onboarding/onboarding_page.dart';
import 'presentation/pages/splash/cubit/splash_cubit.dart';
import 'presentation/pages/splash/splash_page.dart';

part 'onboarding_routes.g.dart';

List<RouteBase> get onboardingRoutes => $appRoutes;

/// The launch gate. Its cubit resolves where to go the moment the page mounts.
@TypedGoRoute<SplashRoute>(
  path: AppRoute.splashPath,
  name: AppRoute.splashName,
)
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SplashCubit>(
      create: (_) => getIt<SplashCubit>()..resolveStartDestination(),
      child: const SplashPage(),
    );
  }
}

@TypedGoRoute<OnboardingRoute>(
  path: AppRoute.onboardingPath,
  name: AppRoute.onboardingName,
)
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OnboardingCubit>(
      create: (_) => getIt<OnboardingCubit>(),
      child: const OnboardingPage(),
    );
  }
}
