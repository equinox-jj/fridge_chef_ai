import 'package:core/di/di.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/pending_dietary_preference_store.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';

import 'data/datasources/local/onboarding_local_data_source.dart';
import 'data/datasources/local/onboarding_local_data_source_impl.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'domain/usecases/complete_onboarding_usecase.dart';
import 'domain/usecases/has_completed_onboarding_usecase.dart';
import 'presentation/pages/onboarding/cubit/onboarding_cubit.dart';
import 'presentation/pages/splash/cubit/splash_cubit.dart';

/// Registers the onboarding feature's dependencies on [getIt].
///
/// Expects a [SharedPreferencesAsync] to already be registered (the app's
/// shared key-value store).
void initOnboardingInjector() {
  getIt
    // Data source
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(
        prefs: getIt<SharedPreferencesAsync>(),
        logger: getIt<AppLogger>(),
      ),
    )
    // Repository
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(
        localDataSource: getIt<OnboardingLocalDataSource>(),
        pendingDietaryPreferenceStore: getIt<PendingDietaryPreferenceStore>(),
        logger: getIt<AppLogger>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<HasCompletedOnboardingUseCase>(
      () => HasCompletedOnboardingUseCase(getIt<OnboardingRepository>()),
    )
    ..registerLazySingleton<CompleteOnboardingUseCase>(
      () => CompleteOnboardingUseCase(getIt<OnboardingRepository>()),
    )
    // Cubits
    ..registerFactory<SplashCubit>(
      () => SplashCubit(getIt<HasCompletedOnboardingUseCase>()),
    )
    ..registerFactory<OnboardingCubit>(
      () => OnboardingCubit(getIt<CompleteOnboardingUseCase>()),
    );
}
