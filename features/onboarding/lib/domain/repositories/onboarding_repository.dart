import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

/// Domain contract for the first-run onboarding flow. Every operation returns
/// an `Either<Failure, T>`: [Left] on failure, [Right] on success.
abstract class OnboardingRepository {
  /// Whether the user has already finished (or skipped) onboarding, so the
  /// splash gate can route returning users straight past it.
  Future<Either<Failure, bool>> hasCompletedOnboarding();

  /// Marks onboarding as done so it is never shown again, optionally recording
  /// the [dietaryPreference] the user picked during setup.
  ///
  /// The preference is `null` when the user skipped dietary setup. It is stored
  /// on-device (the user is not authenticated yet) for the profile to adopt
  /// once an account exists.
  Future<Either<Failure, Unit>> completeOnboarding({
    DietaryPreference? dietaryPreference,
  });
}
