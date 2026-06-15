import 'package:auth/auth_injector.dart';
import 'package:core/blocs/connectivity_bloc.dart';
import 'package:core/database/app_database.dart';
import 'package:core/di/di.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/services/image_compression_service_impl.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/pending_dietary_preference_store.dart';
import 'package:core/services/permission_service.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:fridge_scan/fridge_scan_injector.dart';
import 'package:onboarding/onboarding_injector.dart';
import 'package:profile/profile_injector.dart';
import 'package:recipes/recipes_injector.dart';

import 'router/app_navigator_impl.dart';
import 'router/app_router.dart';

/// Wires every dependency the app needs. Call once after Supabase/Firebase
/// have been initialised and before `runApp`.
void configureDependencies() {
  getIt.registerLazySingleton<AppLogger>(
    AppLoggerImpl.new,
  );
  getIt.registerLazySingleton<SupabaseService>(
    () => SupabaseService(
      Supabase.instance.client,
      getIt<AppLogger>(),
    ),
  );
  getIt.registerLazySingleton<PermissionService>(
    PermissionService.new,
  );
  getIt.registerLazySingleton<ImagePickerService>(
    ImagePickerService.new,
  );
  getIt.registerLazySingleton<ImageCompressionService>(
    ImageCompressionServiceImpl.new,
  );
  getIt.registerLazySingleton<ConnectivityService>(
    ConnectivityServiceImpl.new,
  );
  getIt.registerLazySingleton<SharedPreferencesAsync>(
    SharedPreferencesAsync.new,
  );
  getIt.registerLazySingleton<PendingDietaryPreferenceStore>(
    () => PendingDietaryPreferenceStore(
      getIt<SharedPreferencesAsync>(),
      getIt<AppLogger>(),
    ),
  );
  getIt.registerLazySingleton<AppDatabase>(
    AppDatabase.new,
    dispose: (AppDatabase db) => db.close(),
  );
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<SupabaseService>()),
  );
  getIt.registerLazySingleton<AppNavigator>(
    () => AppNavigatorImpl(getIt<AppRouter>().config),
  );
  getIt.registerLazySingleton<ConnectivityBloc>(
    () => ConnectivityBloc(getIt<ConnectivityService>()),
    dispose: (ConnectivityBloc bloc) => bloc.close(),
  );

  initOnboardingInjector();
  initAuthInjector();
  initFridgeScanInjector();
  initProfileInjector();
  initRecipesInjector();
}
