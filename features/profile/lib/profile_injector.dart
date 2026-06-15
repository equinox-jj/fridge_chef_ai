import 'package:core/database/app_database.dart';
import 'package:core/di/di.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/permission_service.dart';
import 'package:core/services/supabase_service.dart';

import 'data/datasources/local/profile_local_data_source.dart';
import 'data/datasources/local/profile_local_data_source_impl.dart';
import 'data/datasources/remote/profile_remote_data_source.dart';
import 'data/datasources/remote/profile_remote_data_source_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/get_profile_usecase.dart';
import 'domain/usecases/get_scan_count_usecase.dart';
import 'domain/usecases/remove_avatar_usecase.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'domain/usecases/update_avatar_usecase.dart';
import 'domain/usecases/update_dietary_preference_usecase.dart';
import 'presentation/pages/profile/cubit/profile_cubit.dart';

/// Registers the profile feature's dependencies on [getIt].
///
/// Call this after `Supabase.initialize(...)` has completed.
void initProfileInjector() {
  getIt
    // Data sources
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(getIt<SupabaseService>()),
    )
    ..registerLazySingleton<ProfileLocalDataSource>(
      () =>
          ProfileLocalDataSourceImpl(getIt<AppDatabase>(), getIt<AppLogger>()),
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
    ..registerLazySingleton<UpdateAvatarUseCase>(
      () => UpdateAvatarUseCase(getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<RemoveAvatarUseCase>(
      () => RemoveAvatarUseCase(getIt<ProfileRepository>()),
    )
    // Cubits
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(
        getIt<GetProfileUseCase>(),
        getIt<GetScanCountUseCase>(),
        getIt<UpdateDietaryPreferenceUseCase>(),
        getIt<SignOutUseCase>(),
        getIt<UpdateAvatarUseCase>(),
        getIt<RemoveAvatarUseCase>(),
        getIt<PermissionService>(),
        getIt<ImagePickerService>(),
      ),
    );
}
