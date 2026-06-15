import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:core/services/pending_dietary_preference_store.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/local/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl
    with RepositoryGuard
    implements OnboardingRepository {
  OnboardingRepositoryImpl({
    required this._localDataSource,
    required this._pendingDietaryPreferenceStore,
    required this.logger,
  });

  final OnboardingLocalDataSource _localDataSource;
  final PendingDietaryPreferenceStore _pendingDietaryPreferenceStore;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, bool>> hasCompletedOnboarding() {
    return guard(() => _localDataSource.hasCompletedOnboarding());
  }

  @override
  Future<Either<Failure, Unit>> completeOnboarding({
    DietaryPreference? dietaryPreference,
  }) {
    return guard(() async {
      // Park the choice for sign-up to adopt into the new profile (the user is
      // not authenticated yet). Best-effort, so it never blocks completion.
      if (dietaryPreference != null) {
        await _pendingDietaryPreferenceStore.save(dietaryPreference);
      }
      await _localDataSource.setCompleted();
      return unit;
    });
  }
}
