import 'package:core/router/app_route.dart';
import 'package:core/router/nav_keys/navigator_keys.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
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

/// Every route owned by the recipes feature, exposed for app composition.
///
/// Mounted as the recipes branch of the dashboard's bottom-navigation shell.
/// The branch carries three routes: the URL-addressable Recipes tab
/// ([RecipesRoute]) plus the recipe-generation flow ([RecipeGenerationRoute],
/// [RecipeDetailRoute]). The flow routes set `$parentNavigatorKey` to the
/// [rootNavigatorKey], so although they live in the branch list they present
/// full-screen *above* the shell — no bottom navigation — over whichever tab
/// launched them.
///
/// Each flow screen is addressed by an in-memory `$extra` argument — a
/// generated recipe has no id to put in the URL — so the typed routes carry
/// the args as a `$extra` field and build their blocs per-navigation from it,
/// mirroring the ingredient-review hand-off.
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
  ],
)
class RecipesRoute extends GoRouteData with $RecipesRoute {
  const RecipesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RecipesPage();
  }
}

class RecipeGenerationRoute extends GoRouteData with $RecipeGenerationRoute {
  const RecipeGenerationRoute({this.$extra});

  /// Presents full-screen on the root navigator, above the dashboard shell.
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

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

class RecipeDetailRoute extends GoRouteData with $RecipeDetailRoute {
  const RecipeDetailRoute({this.$extra});

  /// Presents full-screen on the root navigator, above the dashboard shell.
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

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
      body: const Center(
        child: Text('This recipe is no longer available. Start a new scan to cook again.'),
      ),
    );
  }
}
