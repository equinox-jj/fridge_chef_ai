import 'package:core/blocs/connectivity_bloc.dart';
import 'package:core/di/di.dart';
import 'package:core/router/app_route.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
import 'package:core/router/nav_keys/navigator_keys.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'domain/usecases/generate_recipes_usecase.dart';
import 'domain/usecases/get_cookbook_usecase.dart';
import 'domain/usecases/get_dietary_preference_usecase.dart';
import 'domain/usecases/get_recipe_detail_usecase.dart';
import 'domain/usecases/save_recipe_usecase.dart';
import 'presentation/args/recipe_detail_args.dart';
import 'presentation/pages/cookbook/bloc/cookbook_bloc.dart';
import 'presentation/pages/cookbook/cookbook_page.dart';
import 'presentation/pages/detail/cubit/save_recipe_cubit.dart';
import 'presentation/pages/detail/recipe_detail_page.dart';
import 'presentation/pages/generate/bloc/recipe_generation_bloc.dart';
import 'presentation/pages/generate/generate_recipes_page.dart';
import 'presentation/pages/saved_detail/cubit/recipe_detail_cubit.dart';
import 'presentation/pages/saved_detail/saved_recipe_detail_page.dart';

part 'recipes_routes.g.dart';

List<RouteBase> get recipesRoutes => $appRoutes;

@TypedGoRoute<RecipesRoute>(
  path: AppRoute.recipesPath,
  name: AppRoute.recipesName,
  routes: <TypedRoute<RouteData>>[
    // Nested under the recipes tab rather than declared as sibling branch
    // routes: a direct child of a shell branch may not set a root
    // `parentNavigatorKey`, but a *nested* route may — that's what lets these
    // present full-screen over the shell.
    TypedGoRoute<RecipeGenerationRoute>(
      path: AppRoute.recipeGenerationPath,
      name: AppRoute.recipeGenerationName,
    ),
    TypedGoRoute<RecipeDetailRoute>(
      path: AppRoute.recipeDetailPath,
      name: AppRoute.recipeDetailName,
    ),
    TypedGoRoute<RecipeDetailViewRoute>(
      path: AppRoute.savedRecipeDetailPath,
      name: AppRoute.savedRecipeDetailName,
    ),
  ],
)
class RecipesRoute extends GoRouteData with $RecipesRoute {
  const RecipesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<CookbookBloc>(
      create: (_) => CookbookBloc(
        getIt<GetCookbookUseCase>(),
        getIt<ConnectivityBloc>(),
      )..add(const CookbookEvent.started()),
      child: const CookbookPage(),
    );
  }
}

class RecipeGenerationRoute extends GoRouteData with $RecipeGenerationRoute {
  const RecipeGenerationRoute({this.$extra});

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final RecipeGenerationArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final RecipeGenerationArgs? args = $extra;
    if (args == null) return const _MissingArgs();
    return BlocProvider<RecipeGenerationBloc>(
      create: (_) => RecipeGenerationBloc(
        getIt<GenerateRecipesUseCase>(),
        getIt<GetDietaryPreferenceUseCase>(),
        args: args,
      )..add(const RecipeGenerationEvent.started()),
      child: const GenerateRecipesPage(),
    );
  }
}

class RecipeDetailRoute extends GoRouteData with $RecipeDetailRoute {
  const RecipeDetailRoute({this.$extra});

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final RecipeDetailArgs? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final RecipeDetailArgs? args = $extra;
    if (args == null) return const _MissingArgs();
    return BlocProvider<SaveRecipeCubit>(
      create: (_) => SaveRecipeCubit(
        getIt<SaveRecipeUseCase>(),
        args.recipe,
        args.scanId,
      ),
      child: RecipeDetailPage(recipe: args.recipe),
    );
  }
}

/// A saved recipe opened from the cookbook, addressed by its [id] (so it
/// survives deep links and hot restarts, unlike the in-memory flow routes).
///
/// Presents full-screen on the root navigator, above the dashboard shell, and
/// loads the full recipe cache-first via [RecipeDetailCubit].
class RecipeDetailViewRoute extends GoRouteData with $RecipeDetailViewRoute {
  const RecipeDetailViewRoute({required this.id});

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<RecipeDetailCubit>(
      create: (_) => RecipeDetailCubit(
        getIt<GetRecipeDetailUseCase>(),
        id,
      )..load(),
      child: const SavedRecipeDetailPage(),
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
      body: const Center(
        child: Text(
          'This recipe is no longer available. Start a new scan to cook again.',
        ),
      ),
    );
  }
}
