import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/onboarding_repository.dart';

/// Reads whether onboarding has already been completed — the single decision
/// the splash gate needs to route the user.
class HasCompletedOnboardingUseCase implements UseCase<bool, NoParams> {
  const HasCompletedOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.hasCompletedOnboarding();
  }
}
