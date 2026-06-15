import 'package:core/database/app_database.dart';
import 'package:core/di/di.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/services/image_compression_service_impl.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/permission_service.dart';
import 'package:core/services/supabase_service.dart';

import 'data/datasources/local/fridge_scan_local_data_source.dart';
import 'data/datasources/local/fridge_scan_local_data_source_impl.dart';
import 'data/datasources/remote/fridge_scan_remote_data_source.dart';
import 'data/datasources/remote/fridge_scan_remote_data_source_impl.dart';
import 'data/repositories/fridge_scan_repository_impl.dart';
import 'domain/repositories/fridge_scan_repository.dart';
import 'domain/usecases/get_recent_scans_usecase.dart';
import 'domain/usecases/get_scan_history_usecase.dart';
import 'domain/usecases/get_user_profile_usecase.dart';
import 'domain/usecases/scan_fridge_usecase.dart';
import 'presentation/pages/home/bloc/home_bloc.dart';
import 'presentation/pages/scan/bloc/scan_bloc.dart';
import 'presentation/pages/scan_history/cubit/scan_history_cubit.dart';

/// Registers the fridge-scan feature's dependencies on [getIt].
///
/// Call this after `Supabase.initialize(...)` and `Firebase.initializeApp(...)`
/// have completed.
void initFridgeScanInjector() {
  getIt
    // Data sources
    ..registerLazySingleton<FridgeScanRemoteDataSource>(
      () => FridgeScanRemoteDataSourceImpl(
        supabaseService: getIt<SupabaseService>(),
        logger: getIt<AppLogger>(),
      ),
    )
    ..registerLazySingleton<FridgeScanLocalDataSource>(
      () => FridgeScanLocalDataSourceImpl(
        database: getIt<AppDatabase>(),
        logger: getIt<AppLogger>(),
      ),
    )
    // Repositories
    ..registerLazySingleton<FridgeScanRepository>(
      () => FridgeScanRepositoryImpl(
        remoteDataSource: getIt<FridgeScanRemoteDataSource>(),
        localDataSource: getIt<FridgeScanLocalDataSource>(),
        connectivity: getIt<ConnectivityService>(),
        compressionService: getIt<ImageCompressionService>(),
        logger: getIt<AppLogger>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<ScanFridgeUseCase>(
      () => ScanFridgeUseCase(getIt<FridgeScanRepository>()),
    )
    ..registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(getIt<FridgeScanRepository>()),
    )
    ..registerLazySingleton<GetRecentScansUseCase>(
      () => GetRecentScansUseCase(getIt<FridgeScanRepository>()),
    )
    ..registerLazySingleton<GetScanHistoryUseCase>(
      () => GetScanHistoryUseCase(getIt<FridgeScanRepository>()),
    )
    // Bloc
    ..registerFactory<HomeBloc>(
      () => HomeBloc(
        getIt<GetUserProfileUseCase>(),
        getIt<GetRecentScansUseCase>(),
      ),
    )
    ..registerFactory<ScanBloc>(
      () => ScanBloc(
        getIt<ScanFridgeUseCase>(),
        getIt<PermissionService>(),
        getIt<ImagePickerService>(),
      ),
    )
    ..registerFactory<ScanHistoryCubit>(
      () => ScanHistoryCubit(getIt<GetScanHistoryUseCase>()),
    );
}
