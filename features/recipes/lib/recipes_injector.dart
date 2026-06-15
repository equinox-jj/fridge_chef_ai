import 'package:core/database/app_database.dart';
import 'package:core/di/di.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/services/supabase_service.dart';

import 'data/datasources/local/recipe_local_data_source.dart';
import 'data/datasources/local/recipe_local_data_source_impl.dart';
import 'data/datasources/remote/recipe_remote_data_source.dart';
import 'data/datasources/remote/recipe_remote_data_source_impl.dart';
import 'data/repositories/recipe_repository_impl.dart';
import 'domain/repositories/recipe_repository.dart';
import 'domain/usecases/generate_recipes_usecase.dart';
import 'domain/usecases/get_cookbook_usecase.dart';
import 'domain/usecases/get_dietary_preference_usecase.dart';
import 'domain/usecases/get_recipe_detail_usecase.dart';
import 'domain/usecases/save_recipe_usecase.dart';

/// Registers the recipes feature's data sources, repository and use cases on
/// [getIt].
///
/// Blocs/cubits are not registered here: they need per-navigation arguments
/// (the seeded ingredients, the recipe being saved), so the routes construct
/// them directly with these use cases — mirroring how the ingredient-review
/// cubit is built.
///
/// Call after `Supabase.initialize(...)` and `Firebase.initializeApp(...)`.
void initRecipesInjector() {
  getIt
    // Data sources
    ..registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(
        supabaseService: getIt<SupabaseService>(),
        logger: getIt<AppLogger>(),
      ),
    )
    ..registerLazySingleton<RecipeLocalDataSource>(
      () => RecipeLocalDataSourceImpl(
        database: getIt<AppDatabase>(),
        logger: getIt<AppLogger>(),
      ),
    )
    // Repository
    ..registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(
        remoteDataSource: getIt<RecipeRemoteDataSource>(),
        localDataSource: getIt<RecipeLocalDataSource>(),
        connectivity: getIt<ConnectivityService>(),
        logger: getIt<AppLogger>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<GenerateRecipesUseCase>(
      () => GenerateRecipesUseCase(getIt<RecipeRepository>()),
    )
    ..registerLazySingleton<GetCookbookUseCase>(
      () => GetCookbookUseCase(getIt<RecipeRepository>()),
    )
    ..registerLazySingleton<GetRecipeDetailUseCase>(
      () => GetRecipeDetailUseCase(getIt<RecipeRepository>()),
    )
    ..registerLazySingleton<GetDietaryPreferenceUseCase>(
      () => GetDietaryPreferenceUseCase(getIt<RecipeRepository>()),
    )
    ..registerLazySingleton<SaveRecipeUseCase>(
      () => SaveRecipeUseCase(getIt<RecipeRepository>()),
    );
}
