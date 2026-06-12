import 'package:core/router/app_route.dart';
import 'package:core/router/recipe_generation_args.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'domain/usecases/generate_recipes_usecase.dart';
import 'domain/usecases/get_dietary_preference_usecase.dart';
import 'domain/usecases/save_recipe_usecase.dart';
import 'presentation/args/recipe_detail_args.dart';
import 'presentation/pages/detail/cubit/save_recipe_cubit.dart';
import 'presentation/pages/detail/recipe_detail_page.dart';
import 'presentation/pages/generate/bloc/recipe_generation_bloc.dart';
import 'presentation/pages/generate/generate_recipes_page.dart';
import 'presentation/pages/recipes/recipes_page.dart';

part 'recipes_routes.g.dart';

/// The generated, URL-addressable Recipes tab, exposed for app composition.
///
/// Nested inside the dashboard's bottom-navigation shell. Composed from the
/// generated [$recipesRoute] rather than `$appRoutes` so the flow routes below
/// can be mounted separately, above the shell.
List<RouteBase> get recipesRoutes => <RouteBase>[$recipesRoute];

/// The full-screen recipe-generation flow (mood → AI → results → detail),
/// pushed over the dashboard shell rather than nested in a tab.
///
/// Each screen is addressed by an in-memory `$extra` argument — a generated
/// recipe has no id to put in the URL — so the typed routes carry the args as
/// a `$extra` field and build their blocs per-navigation from it, mirroring the
/// ingredient-review hand-off.
List<RouteBase> get recipeFlowRoutes => <RouteBase>[
  $recipeGenerationRoute,
  $recipeDetailRoute,
];

@TypedGoRoute<RecipesRoute>(
  path: AppRoute.recipesPath,
  name: AppRoute.recipesName,
)
class RecipesRoute extends GoRouteData with $RecipesRoute {
  const RecipesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RecipesPage();
  }
}

@TypedGoRoute<RecipeGenerationRoute>(
  path: AppRoute.recipeGenerationPath,
  name: AppRoute.recipeGenerationName,
)
class RecipeGenerationRoute extends GoRouteData with $RecipeGenerationRoute {
  const RecipeGenerationRoute({this.$extra});

  final RecipeGenerationArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final RecipeGenerationArgs? args = $extra;
    if (args == null) return const _MissingArgs();
    return BlocProvider<RecipeGenerationBloc>(
      create: (_) => RecipeGenerationBloc(
        GetIt.I<GenerateRecipesUseCase>(),
        GetIt.I<GetDietaryPreferenceUseCase>(),
        args: args,
      )..add(const RecipeGenerationEvent.started()),
      child: const GenerateRecipesPage(),
    );
  }
}

@TypedGoRoute<RecipeDetailRoute>(
  path: AppRoute.recipeDetailPath,
  name: AppRoute.recipeDetailName,
)
class RecipeDetailRoute extends GoRouteData with $RecipeDetailRoute {
  const RecipeDetailRoute({this.$extra});

  final RecipeDetailArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final RecipeDetailArgs? args = $extra;
    if (args == null) return const _MissingArgs();
    return BlocProvider<SaveRecipeCubit>(
      create: (_) => SaveRecipeCubit(
        GetIt.I<SaveRecipeUseCase>(),
        args.recipe,
        args.scanId,
      ),
      child: RecipeDetailPage(recipe: args.recipe),
    );
  }
}

/// Shown if a flow route is reached without its in-memory argument (e.g. a deep
/// link or a hot restart mid-flow) — a dead end is friendlier than a crash.
class _MissingArgs extends StatelessWidget {
  const _MissingArgs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('This recipe is no longer available. Start a new scan to cook again.')),
    );
  }
}
