import 'app_route.dart';

/// Routes that can be visited without an authenticated session.
const Set<String> _publicPaths = <String>{
  AppRoute.onboardingPath,
  AppRoute.signInPath,
  AppRoute.signUpPath,
  AppRoute.forgotPasswordPath,
};

/// Auth-flow routes that an already-authenticated user should be bounced away
/// from (e.g. there is no reason to show sign-in to a signed-in user).
const Set<String> _authPaths = <String>{
  AppRoute.signInPath,
  AppRoute.signUpPath,
  AppRoute.forgotPasswordPath,
};

/// Pure, dependency-free guard used by the app's `GoRouter.redirect`.
///
/// Returns the location to redirect to, or `null` to allow the navigation:
///   * unauthenticated users are sent to sign-in for any protected route;
///   * authenticated users are kept out of the auth pages (sent to dashboard).
///
/// Keeping this a plain function makes the guard trivially unit-testable
/// without a widget tree, a router, or Supabase.
String? authGuardRedirect({
  required bool isLoggedIn,
  required String location,
}) {
  final bool isPublic = _publicPaths.contains(location);
  final bool isAuthPage = _authPaths.contains(location);

  if (!isLoggedIn && !isPublic) {
    return AppRoute.signInPath;
  }
  if (isLoggedIn && isAuthPage) {
    return AppRoute.fridgeScanPath;
  }
  return null;
}
