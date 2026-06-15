import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:core/router/args/recipe_generation_args.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/recipe_entity.dart';
import '../../domain/entities/saved_recipe_entity.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/ai/recipe_ai_data_source.dart';
import '../datasources/local/recipe_local_data_source.dart';
import '../datasources/remote/recipe_remote_data_source.dart';
import '../mapper/recipe_mapper.dart';
import '../mapper/saved_recipe_mapper.dart';
import '../models/recipe_model.dart';
import '../models/saved_recipe_model.dart';

class RecipeRepositoryImpl with RepositoryGuard implements RecipeRepository {
  RecipeRepositoryImpl({
    required this._aiDataSource,
    required this._remoteDataSource,
    required this._localDataSource,
    required this._connectivity,
    required this.logger,
  });

  final RecipeAiDataSource _aiDataSource;
  final RecipeRemoteDataSource _remoteDataSource;
  final RecipeLocalDataSource _localDataSource;
  final ConnectivityService _connectivity;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, List<SavedRecipeEntity>>> getCookbook() {
    return guard(() async {
      // Offline-first: when online, refresh the on-device mirror from the
      // backend; then always read from the cache so the cookbook renders the
      // same whether or not there's a connection. A failed refresh is
      // swallowed (logged) rather than failing the read — the cache still
      // serves what we have.
      if (await _connectivity.isOnline) {
        await _refreshCookbookCache();
      }
      final List<SavedRecipeModel> cached = await _localDataSource
          .getCookbook();
      return cached.map((SavedRecipeModel m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, RecipeEntity>> getRecipeDetail({required String id}) {
    return guard(() async {
      // Cache-first: when online, fetch the full recipe and write it through to
      // the cache so it's readable offline next time. A failed fetch falls back
      // to the cache rather than erroring — the recipe may already be cached.
      if (await _connectivity.isOnline) {
        try {
          final RecipeModel remote = await _remoteDataSource.getRecipeById(
            id: id,
          );
          await _cacheRecipeDetail(id, remote);
          return remote.toEntity();
        } on AppException catch (e, stackTrace) {
          logger.warning(
            'Recipe detail fetch failed; serving cache',
            error: e,
            stackTrace: stackTrace,
          );
        }
      }

      final RecipeModel? cached = await _localDataSource.getRecipeDetail(
        id: id,
      );
      if (cached == null) {
        // Offline (or the fetch failed) with nothing cached: this recipe was
        // never opened online, so there's nothing to show.
        throw const CacheException(
          "This recipe isn't available offline yet. Reconnect to open it.",
        );
      }
      return cached.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> generateRecipes({
    required List<RecipeSeedIngredient> ingredients,
    required String mood,
    required String dietaryPreference,
  }) {
    return guard(() async {
      final List<RecipeModel> recipes = await _aiDataSource.generateRecipes(
        ingredientLines: ingredients.map(_describe).toList(),
        mood: mood,
        dietaryPreference: dietaryPreference,
      );
      return recipes.map((RecipeModel model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, String>> getDietaryPreference() {
    return guard(() => _remoteDataSource.getDietaryPreference());
  }

  @override
  Future<Either<Failure, Unit>> saveRecipe({
    required RecipeEntity recipe,
    required int rating,
    String? note,
    String? scanId,
  }) {
    return guard(() async {
      final SavedRecipeModel saved = await _remoteDataSource.saveRecipe(
        recipe: recipe.toModel(),
        rating: rating,
        note: note,
        scanId: scanId,
      );
      // Write-through: drop the new entry into the cache so it's in the
      // cookbook immediately, offline included. A cache hiccup mustn't fail the
      // save the user just completed — log and move on.
      try {
        await _localDataSource.upsert(saved);
      } on CacheException catch (e, stackTrace) {
        logger.warning(
          'Failed to cache saved recipe',
          error: e,
          stackTrace: stackTrace,
        );
      }
      return unit;
    });
  }

  /// Writes a freshly fetched recipe detail into the cache. A cache hiccup
  /// mustn't fail a fetch that already succeeded — log and move on (the recipe
  /// still shows this time, just won't be there offline next time).
  Future<void> _cacheRecipeDetail(String id, RecipeModel recipe) async {
    try {
      await _localDataSource.cacheRecipeDetail(id: id, recipe: recipe);
    } on CacheException catch (e, stackTrace) {
      logger.warning(
        'Failed to cache recipe detail',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Pulls the cookbook from the backend and replaces the local cache with it.
  /// Swallows failures so an offline read still falls through to the cache.
  Future<void> _refreshCookbookCache() async {
    try {
      final List<SavedRecipeModel> remote = await _remoteDataSource
          .getSavedRecipes();
      await _localDataSource.replaceCookbook(remote);
    } on AppException catch (e, stackTrace) {
      logger.warning(
        'Cookbook refresh failed; serving cache',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Renders a seed ingredient as a single prompt line, e.g. "2 pcs egg",
  /// "200 g flour", or just "garlic" when no amount is known.
  String _describe(RecipeSeedIngredient ingredient) {
    final String quantity = ingredient.quantity?.trim() ?? '';
    final String unit = ingredient.unit?.trim() ?? '';
    final String name = ingredient.name.trim();
    return <String>[
      quantity,
      unit,
      name,
    ].where((String s) => s.isNotEmpty).join(' ');
  }
}
