import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/onboarding_repository.dart';

/// Finishes onboarding, persisting the completion flag and the optionally
/// chosen [CompleteOnboardingParams.dietaryPreference].
class CompleteOnboardingUseCase implements UseCase<Unit, CompleteOnboardingParams> {
  const CompleteOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(CompleteOnboardingParams params) {
    return _repository.completeOnboarding(
      dietaryPreference: params.dietaryPreference,
    );
  }
}

/// Input for [CompleteOnboardingUseCase]. A `null` [dietaryPreference] means the
/// user skipped dietary setup, so nothing is recorded for it.
class CompleteOnboardingParams {
  const CompleteOnboardingParams({this.dietaryPreference});

  final DietaryPreference? dietaryPreference;
}
