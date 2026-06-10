import 'package:auth/auth_routes.dart' show authRoutes;
import 'package:core/router/app_route.dart';
import 'package:core/router/auth_redirect.dart';
import 'package:core/router/go_router_refresh_stream.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dashboard/dashboard_routes.dart' show dashboardRoutes;
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge_scan/fridge_scan_routes.dart' show fridgeScanRoutes;
import 'package:onboarding/onboarding_routes.dart' show onboardingRoutes;

/// Builds and owns the app's [GoRouter].
///
/// Routes are not declared here — each feature owns and exports its own
/// `List<RouteBase>`; this class only composes them and applies the
/// session-based redirect. Taking [SupabaseService] as a dependency keeps the
/// router testable (a fake service drives the guard without real auth).
class AppRouter {
  AppRouter(this._supabaseService);

  final SupabaseService _supabaseService;

  late final GoRouter config = GoRouter(
    initialLocation: AppRoute.dashboardPath,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      _supabaseService.authStateChanges,
    ),
    redirect: (BuildContext context, GoRouterState state) => authGuardRedirect(
      isLoggedIn: _supabaseService.currentSession != null,
      location: state.matchedLocation,
    ),
    routes: <RouteBase>[
      ...onboardingRoutes,
      ...authRoutes,
      ...dashboardRoutes,
      ...fridgeScanRoutes,
    ],
  );
}
