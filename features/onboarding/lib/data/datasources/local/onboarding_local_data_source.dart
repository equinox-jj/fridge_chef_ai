/// Persists whether the first-run onboarding has been completed, so the splash
/// gate can route returning users straight past it.
abstract class OnboardingLocalDataSource {
  /// Returns `true` once onboarding has been completed; `false` on first run.
  Future<bool> hasCompletedOnboarding();

  /// Records that onboarding has been completed.
  Future<void> setCompleted();
}
