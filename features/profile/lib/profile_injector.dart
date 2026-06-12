import 'package:core/logger/app_logger.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';

import 'data/datasources/remote/profile_remote_data_source.dart';
import 'data/datasources/remote/profile_remote_data_source_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/sign_out_usecase.dart';
import 'presentation/pages/profile/cubit/profile_cubit.dart';

/// Registers the profile feature's dependencies on [getIt].
///
/// Call this after `Supabase.initialize(...)` has completed.
void initProfileInjector(GetIt getIt) {
  getIt
    // Data source
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(getIt<SupabaseService>()),
    )
    // Repository
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        getIt<ProfileRemoteDataSource>(),
        getIt<AppLogger>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(getIt<ProfileRepository>()),
    )
    // Cubits
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt<SignOutUseCase>()),
    );
}
