import 'package:auth/auth_routes.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:fridge_scan/fridge_scan_routes.dart';
import 'package:onboarding/onboarding_routes.dart';
import 'package:profile/profile_routes.dart';
import 'package:recipes/recipes_routes.dart';

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
  void goToOnboarding() => _router.go(
    const OnboardingRoute().location,
  );

  @override
  void goToSignIn() => _router.go(
    const SignInRoute().location,
  );

  @override
  void pushToSignUp() => _router.push(
    const SignUpRoute().location,
  );

  @override
  void pushToForgotPassword() => _router.push(
    const ForgotPasswordRoute().location,
  );

  @override
  void pushToForgotPasswordConfirmation(String email) => _router.push(
    ForgotPasswordConfirmationRoute(email: email).location,
  );

  @override
  void goToDashboard() => _router.go(
    const HomeRoute().location,
  );

  @override
  void pushToFridgeScan() => _router.push(
    const FridgeScanRoute().location,
  );

  @override
  void goToRecipes() => _router.go(
    const RecipesRoute().location,
  );

  @override
  void pushToRecipeGeneration(RecipeGenerationArgs args) => _router.push(
    RecipeGenerationRoute().location,
    extra: args,
  );

  @override
  void goToProfile() => _router.go(
    const ProfileRoute().location,
  );

  @override
  void pushToScanHistory() => _router.push(
    const ScanHistoryRoute().location,
  );

  @override
  void goToHome() => _router.go(
    const HomeRoute().location,
  );
}
