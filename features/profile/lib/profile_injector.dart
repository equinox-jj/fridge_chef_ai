import 'package:core/database/app_database.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';

import 'data/datasources/local/profile_local_data_source.dart';
import 'data/datasources/local/profile_local_data_source_impl.dart';
import 'data/datasources/remote/profile_remote_data_source.dart';
import 'data/datasources/remote/profile_remote_data_source_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/get_scan_count_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/update_dietary_preference_usecase.dart';
import 'presentation/pages/profile/cubit/profile_cubit.dart';

/// Registers the profile feature's dependencies on [getIt].
///
/// Call this after `Supabase.initialize(...)` has completed.
void initProfileInjector(GetIt getIt) {
  getIt
    // Data sources
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(getIt<SupabaseService>()),
    )
    ..registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(getIt<AppDatabase>(), getIt<AppLogger>()),
    )
    // Repository
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        getIt<ProfileRemoteDataSource>(),
        getIt<ProfileLocalDataSource>(),
        getIt<AppLogger>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<GetScanCountUseCase>(
      () => GetScanCountUseCase(getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<UpdateDietaryPreferenceUseCase>(
      () => UpdateDietaryPreferenceUseCase(getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(getIt<ProfileRepository>()),
    )
    // Cubits
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(
        getIt<GetProfileUseCase>(),
        getIt<GetScanCountUseCase>(),
        getIt<UpdateDietaryPreferenceUseCase>(),
        getIt<SignOutUseCase>(),
      ),
    );
}
