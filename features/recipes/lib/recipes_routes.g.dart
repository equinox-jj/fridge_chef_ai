// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$recipesRoute];

RouteBase get $recipesRoute => GoRouteData.$route(
  path: '/recipes',
  name: 'recipes',
  factory: $RecipesRoute._fromState,
);

mixin $RecipesRoute on GoRouteData {
  static RecipesRoute _fromState(GoRouterState state) => const RecipesRoute();

  @override
  String get location => GoRouteData.$location('/recipes');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
