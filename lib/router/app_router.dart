import 'package:auth/auth_routes.dart' show authRoutes;
import 'package:core/router/app_route.dart';
import 'package:core/router/redirect/auth_redirect.dart';
import 'package:core/router/go_router_refresh_stream.dart';
import 'package:core/router/nav_keys/navigator_keys.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dashboard/dashboard.dart' show DashboardShell;
import 'package:dependencies/go_router/go_router.dart';
import 'package:fridge_scan/fridge_scan_routes.dart' show fridgeScanRoutes;
import 'package:onboarding/onboarding_routes.dart' show onboardingRoutes;
import 'package:profile/profile_routes.dart' show profileRoutes;
import 'package:recipes/recipes_routes.dart' show recipesRoutes;

/// Builds and owns the app's [GoRouter].
///
/// Routes are not declared here — each feature owns and exports its own
/// `List<RouteBase>`; this class only composes them and applies the
/// session-based redirect. The scan, recipes and profile features are composed
/// into a [StatefulShellRoute] hosted by the dashboard's bottom-navigation
/// shell. Taking [SupabaseService] as a dependency keeps the router testable
/// (a fake service drives the guard without real auth).
class AppRouter {
  AppRouter(this._supabaseService);

  final SupabaseService _supabaseService;

  late final GoRouter config = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoute.splashPath,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      _supabaseService.authStateChanges,
    ),
    redirect: (_, GoRouterState state) => authGuardRedirect(
      isLoggedIn: _supabaseService.currentSession != null,
      location: state.matchedLocation,
    ),
    routes: <RouteBase>[
      ...onboardingRoutes,
      ...authRoutes,
      StatefulShellRoute.indexedStack(
        builder: (_, _, StatefulNavigationShell navigationShell) => DashboardShell(
          navigationShell: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: fridgeScanRoutes),
          StatefulShellBranch(routes: recipesRoutes),
          StatefulShellBranch(routes: profileRoutes),
        ],
      ),
    ],
  );
}
