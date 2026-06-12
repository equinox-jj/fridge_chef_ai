import 'package:core/logger/app_logger.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/get_it/get_it.dart';

import 'data/datasources/ai/recipe_ai_data_source.dart';
import 'data/datasources/ai/recipe_ai_data_source_impl.dart';
import 'data/datasources/remote/recipe_remote_data_source.dart';
import 'data/datasources/remote/recipe_remote_data_source_impl.dart';
import 'data/repositories/recipe_repository_impl.dart';
import 'domain/repositories/recipe_repository.dart';
import 'domain/usecases/generate_recipes_usecase.dart';
import 'domain/usecases/get_dietary_preference_usecase.dart';
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
void initRecipesInjector(GetIt getIt) {
  getIt
    // Data sources
    ..registerLazySingleton<RecipeAiDataSource>(
      () => RecipeAiDataSourceImpl(getIt<AppLogger>()),
    )
    ..registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(getIt<SupabaseService>()),
    )
    // Repository
    ..registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(
        getIt<RecipeAiDataSource>(),
        getIt<RecipeRemoteDataSource>(),
        getIt<AppLogger>(),
      ),
    )
    // Use cases
    ..registerLazySingleton<GenerateRecipesUseCase>(
      () => GenerateRecipesUseCase(getIt<RecipeRepository>()),
    )
    ..registerLazySingleton<GetDietaryPreferenceUseCase>(
      () => GetDietaryPreferenceUseCase(getIt<RecipeRepository>()),
    )
    ..registerLazySingleton<SaveRecipeUseCase>(
      () => SaveRecipeUseCase(getIt<RecipeRepository>()),
    );
}
