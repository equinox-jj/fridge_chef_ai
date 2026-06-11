/// Single source of truth for every route's `name` and `path`.
///
/// These constants are referenced by each feature's `@TypedGoRoute`
/// annotations (so the generated routes stay in sync) and by the router's
/// redirect guard, which matches against paths. Features navigate through the
/// [AppNavigator] abstraction rather than touching routes directly, so the
/// feature packages stay decoupled from one another.
abstract final class AppRoute {
  const AppRoute._();

  // ── Onboarding ──────────────────────────────────────────────────────────
  static const String onboardingName = 'onboarding';
  static const String onboardingPath = '/onboarding';

  // ── Auth ────────────────────────────────────────────────────────────────
  static const String signInName = 'signIn';
  static const String signInPath = '/sign-in';

  static const String signUpName = 'signUp';
  static const String signUpPath = '/sign-up';

  static const String forgotPasswordName = 'forgotPassword';
  static const String forgotPasswordPath = '/forgot-password';

  // ── Main shell tabs (hosted by the dashboard bottom navigation) ──────────
  // The scan tab doubles as the app's post-login home.
  static const String homeName = 'home';
  static const String homePath = '/home';

  static const String fridgeScanName = 'fridgeScan';
  static const String fridgeScanPath = 'fridge-scan';

  static const String recipesName = 'recipes';
  static const String recipesPath = '/recipes';

  static const String profileName = 'profile';
  static const String profilePath = '/profile';
}
