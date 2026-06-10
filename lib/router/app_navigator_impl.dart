import 'package:auth/auth_routes.dart';
import 'package:core/router/app_navigator.dart';
import 'package:dashboard/dashboard_routes.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:fridge_scan/fridge_scan_routes.dart';
import 'package:onboarding/onboarding_routes.dart';

/// Concrete [AppNavigator] living in the app layer.
///
/// This is the single seam allowed to import every feature's generated route
/// classes; features themselves stay decoupled behind the [AppNavigator]
/// abstraction. Navigation goes through the shared [GoRouter] using each
/// route's type-safe `location`, so no [BuildContext] is needed at call sites.
class AppNavigatorImpl implements AppNavigator {
  AppNavigatorImpl(this._router);

  final GoRouter _router;

  @override
  void toOnboarding() => _router.go(const OnboardingRoute().location);

  @override
  void toSignIn() => _router.go(const SignInRoute().location);

  @override
  void toSignUp() => _router.push(const SignUpRoute().location);

  @override
  void toForgotPassword() => _router.go(const ForgotPasswordRoute().location);

  @override
  void toDashboard() => _router.go(const DashboardRoute().location);

  @override
  void toFridgeScan() => _router.go(const FridgeScanRoute().location);
}
