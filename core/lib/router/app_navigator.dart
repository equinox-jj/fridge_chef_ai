import 'arguments/recipe_generation_args.dart';

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
/// Getit.I<AppNavigator>().toDashboard();
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

  /// Enters the main app shell, landing on its default (scan) tab.
  void toDashboard();

  /// Switches to the scan tab of the main shell.
  void toFridgeScan();

  /// Switches to the recipes tab of the main shell.
  void toRecipes();

  /// Pushes the full-screen recipe-generation flow (mood → AI → results) over
  /// the current screen, seeded with [args].
  void toRecipeGeneration(RecipeGenerationArgs args);

  /// Switches to the profile tab of the main shell.
  void toProfile();

  void toHome();
}
