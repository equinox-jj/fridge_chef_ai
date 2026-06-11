import 'package:core/database/app_database.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';

import 'data/datasources/ai/fridge_ai_data_source.dart';
import 'data/datasources/ai/fridge_ai_data_source_impl.dart';
import 'data/datasources/local/fridge_scan_local_data_source.dart';
import 'data/datasources/local/fridge_scan_local_data_source_impl.dart';
import 'data/datasources/remote/fridge_scan_remote_data_source.dart';
import 'data/datasources/remote/fridge_scan_remote_data_source_impl.dart';
import 'data/repositories/fridge_scan_repository_impl.dart';
import 'domain/repositories/fridge_scan_repository.dart';
import 'domain/usecases/get_user_profile_usecase.dart';
import 'domain/usecases/scan_fridge_usecase.dart';
import 'presentation/pages/home/bloc/home_bloc.dart';
import 'presentation/pages/scan/bloc/scan_bloc.dart';

/// Registers the fridge-scan feature's dependencies on [getIt].
///
/// Call this after `Supabase.initialize(...)` and `Firebase.initializeApp(...)`
/// have completed.
void initFridgeScanInjector(GetIt getIt) {
  getIt
    // Data sources
    ..registerLazySingleton<FridgeScanRemoteDataSource>(
      () => FridgeScanRemoteDataSourceImpl(getIt<SupabaseService>()),
    )
    ..registerLazySingleton<FridgeAiDataSource>(() => FridgeAiDataSourceImpl())
    ..registerLazySingleton<FridgeScanLocalDataSource>(
      () => FridgeScanLocalDataSourceImpl(getIt<AppDatabase>()),
    )
    // Repositories
    ..registerLazySingleton<FridgeScanRepository>(
      () => FridgeScanRepositoryImpl(
        getIt<FridgeScanRemoteDataSource>(),
        getIt<FridgeScanLocalDataSource>(),
        getIt<FridgeAiDataSource>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<ScanFridgeUseCase>(
      () => ScanFridgeUseCase(getIt<FridgeScanRepository>()),
    )
    ..registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(getIt<FridgeScanRepository>()),
    )
    // Bloc
    ..registerFactory<HomeBloc>(
      () => HomeBloc(getIt<GetUserProfileUseCase>()),
    )
    ..registerFactory<ScanBloc>(() => ScanBloc(getIt<ScanFridgeUseCase>()));
}
