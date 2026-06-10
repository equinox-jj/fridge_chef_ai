import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';

import 'data/datasources/ai/fridge_ai_data_source.dart';
import 'data/datasources/ai/fridge_ai_data_source_impl.dart';
import 'data/datasources/remote/fridge_scan_remote_data_source.dart';
import 'data/datasources/remote/fridge_scan_remote_data_source_impl.dart';
import 'data/repositories/fridge_scan_repository_impl.dart';
import 'domain/repositories/fridge_scan_repository.dart';
import 'domain/usecases/scan_fridge_usecase.dart';
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
    // Repository
    ..registerLazySingleton<FridgeScanRepository>(
      () => FridgeScanRepositoryImpl(
        getIt<FridgeScanRemoteDataSource>(),
        getIt<FridgeAiDataSource>(),
      ),
    )
    // Use case
    ..registerLazySingleton<ScanFridgeUseCase>(
      () => ScanFridgeUseCase(getIt<FridgeScanRepository>()),
    )
    // Bloc
    ..registerFactory<ScanBloc>(() => ScanBloc(getIt<ScanFridgeUseCase>()));
}
