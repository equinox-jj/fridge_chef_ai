import 'package:auth/auth_injector.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:fridge_scan/fridge_scan_injector.dart';

import 'router/app_router.dart';

/// The app-wide service locator.
final GetIt getIt = GetIt.instance;

/// Wires every dependency the app needs. Call once after Supabase/Firebase
/// have been initialised and before `runApp`.
void configureDependencies() {
  // Shared services first, so feature injectors reuse them.
  getIt.registerLazySingleton<SupabaseService>(
    () => SupabaseService(Supabase.instance.client),
  );

  // Router depends on the shared Supabase service for its auth guard.
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(getIt<SupabaseService>()),
  );

  // Feature modules register their own data sources, repositories, use cases
  // and blocs/cubits.
  initAuthInjector(getIt);
  initFridgeScanInjector(getIt);
}
