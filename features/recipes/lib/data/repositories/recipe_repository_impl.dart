import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:core/router/recipe_generation_args.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/recipe_entity.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/ai/recipe_ai_data_source.dart';
import '../datasources/remote/recipe_remote_data_source.dart';
import '../mapper/recipe_mapper.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl with RepositoryGuard implements RecipeRepository {
  RecipeRepositoryImpl(
    this._aiDataSource,
    this._remoteDataSource,
    this.logger,
  );

  final RecipeAiDataSource _aiDataSource;
  final RecipeRemoteDataSource _remoteDataSource;

  @override
  final AppLogger logger;

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
      await _remoteDataSource.saveRecipe(
        recipe: recipe.toModel(),
        rating: rating,
        note: note,
        scanId: scanId,
      );
      return unit;
    });
  }

  /// Renders a seed ingredient as a single prompt line, e.g. "2 pcs egg",
  /// "200 g flour", or just "garlic" when no amount is known.
  String _describe(RecipeSeedIngredient ingredient) {
    final String quantity = ingredient.quantity?.trim() ?? '';
    final String unit = ingredient.unit?.trim() ?? '';
    final String name = ingredient.name.trim();
    return <String>[quantity, unit, name].where((String s) => s.isNotEmpty).join(' ');
  }
}
