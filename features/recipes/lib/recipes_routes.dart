import 'package:core/router/app_route.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/recipes/recipes_page.dart';

part 'recipes_routes.g.dart';

/// Every route owned by the recipes feature, exposed for app composition.
List<RouteBase> get recipesRoutes => $appRoutes;

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
