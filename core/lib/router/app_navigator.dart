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
/// context.read<AppNavigator>().toDashboard();
/// ```
abstract interface class AppNavigator {
  void goToOnboarding();
  void goToSignIn();
  void pushToSignUp();
  void pushToForgotPassword();
  void pushToForgotPasswordConfirmation(
    String email,
  );
  void goToDashboard();
  void pushToFridgeScan();
  void goToRecipes();
  void pushToRecipeGeneration(
    RecipeGenerationArgs args,
  );
  void goToProfile();
  void pushToScanHistory();
  void goToHome();
}
