/// Intent-based navigation contract for the whole app.
///
/// Features depend on this abstraction (declared in `core`) instead of on one
/// another's generated route classes, so the feature packages stay decoupled.
/// The concrete implementation lives in the app layer — the only place that
/// may import every feature's routes — and is provided via the service locator.
///
/// Call sites read it from `GetIt` and express *where* they want to go, not
/// *how*:
///
/// ```dart
/// GetIt.instance<AppNavigator>().toDashboard();
/// ```
abstract interface class AppNavigator {
  /// Replaces the stack with the onboarding screen.
  void toOnboarding();

  /// Replaces the stack with the sign-in screen.
  void toSignIn();

  /// Replaces the stack with the sign-up screen.
  void toSignUp();

  /// Replaces the stack with the forgot-password screen.
  void toForgotPassword();

  /// Replaces the stack with the dashboard.
  void toDashboard();

  /// Replaces the stack with the fridge-scan screen.
  void toFridgeScan();
}
