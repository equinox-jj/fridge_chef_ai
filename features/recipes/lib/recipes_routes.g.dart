// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $recipesRoute,
  $recipeGenerationRoute,
  $recipeDetailRoute,
];

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

RouteBase get $recipeGenerationRoute => GoRouteData.$route(
  path: '/recipe-generation',
  name: 'recipeGeneration',
  factory: $RecipeGenerationRoute._fromState,
);

mixin $RecipeGenerationRoute on GoRouteData {
  static RecipeGenerationRoute _fromState(GoRouterState state) =>
      RecipeGenerationRoute($extra: state.extra as RecipeGenerationArgs?);

  RecipeGenerationRoute get _self => this as RecipeGenerationRoute;

  @override
  String get location => GoRouteData.$location('/recipe-generation');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) => context.replace(location, extra: _self.$extra);
}

RouteBase get $recipeDetailRoute => GoRouteData.$route(
  path: '/recipe-detail',
  name: 'recipeDetail',
  factory: $RecipeDetailRoute._fromState,
);

mixin $RecipeDetailRoute on GoRouteData {
  static RecipeDetailRoute _fromState(GoRouterState state) =>
      RecipeDetailRoute($extra: state.extra as RecipeDetailArgs?);

  RecipeDetailRoute get _self => this as RecipeDetailRoute;

  @override
  String get location => GoRouteData.$location('/recipe-detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) => context.replace(location, extra: _self.$extra);
}
