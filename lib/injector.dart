import 'package:auth/auth_injector.dart';
import 'package:core/database/app_database.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/pending_dietary_preference_store.dart';
import 'package:core/services/permission_service.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/shared_preferences/shared_preferences.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:fridge_scan/fridge_scan_injector.dart';
import 'package:onboarding/onboarding_injector.dart';
import 'package:profile/profile_injector.dart';
import 'package:recipes/recipes_injector.dart';

import 'router/app_navigator_impl.dart';
import 'router/app_router.dart';

/// The app-wide service locator.
final GetIt getIt = GetIt.I;

/// Wires every dependency the app needs. Call once after Supabase/Firebase
/// have been initialised and before `runApp`.
void configureDependencies() {
  // Shared services first, so feature injectors reuse them.
  getIt.registerLazySingleton<AppLogger>(AppLoggerImpl.new);
  getIt.registerLazySingleton<SupabaseService>(
    () => SupabaseService(Supabase.instance.client, getIt<AppLogger>()),
  );
  getIt.registerLazySingleton<PermissionService>(PermissionService.new);
  getIt.registerLazySingleton<ImagePickerService>(ImagePickerService.new);
  getIt.registerLazySingleton<ConnectivityService>(ConnectivityServiceImpl.new);

  // Shared key-value store for small, pre-auth flags (e.g. onboarding state).
  getIt.registerLazySingleton<SharedPreferencesAsync>(SharedPreferencesAsync.new);

  // Cross-feature handoff for the onboarding dietary choice: onboarding writes
  // it, auth adopts it onto the new profile at sign-up.
  getIt.registerLazySingleton<PendingDietaryPreferenceStore>(
    () => PendingDietaryPreferenceStore(
      getIt<SharedPreferencesAsync>(),
      getIt<AppLogger>(),
    ),
  );

  // Shared local database — features access it through their own data sources.
  getIt.registerLazySingleton<AppDatabase>(
    AppDatabase.new,
    dispose: (AppDatabase db) => db.close(),
  );

  // Router depends on the shared Supabase service for its auth guard.
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<SupabaseService>()),
  );

  // Navigation contract — the impl wraps the router built above and is the
  // only seam that knows about each feature's concrete routes.
  getIt.registerLazySingleton<AppNavigator>(
    () => AppNavigatorImpl(getIt<AppRouter>().config),
  );

  // Feature modules register their own data sources, repositories, use cases
  // and blocs/cubits.
  initOnboardingInjector(getIt);
  initAuthInjector(getIt);
  initFridgeScanInjector(getIt);
  initProfileInjector(getIt);
  initRecipesInjector(getIt);
}
