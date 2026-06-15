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
  routes: [
    GoRouteData.$route(
      path: 'recipe-generation',
      name: 'recipeGeneration',
      parentNavigatorKey: RecipeGenerationRoute.$parentNavigatorKey,
      factory: $RecipeGenerationRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'recipe-detail',
      name: 'recipeDetail',
      parentNavigatorKey: RecipeDetailRoute.$parentNavigatorKey,
      factory: $RecipeDetailRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'saved/:id',
      name: 'savedRecipeDetail',
      parentNavigatorKey: RecipeDetailViewRoute.$parentNavigatorKey,
      factory: $RecipeDetailViewRoute._fromState,
    ),
  ],
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
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RecipeGenerationRoute on GoRouteData {
  static RecipeGenerationRoute _fromState(GoRouterState state) =>
      RecipeGenerationRoute($extra: state.extra as RecipeGenerationArgs?);

  RecipeGenerationRoute get _self => this as RecipeGenerationRoute;

  @override
  String get location => GoRouteData.$location('/recipes/recipe-generation');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $RecipeDetailRoute on GoRouteData {
  static RecipeDetailRoute _fromState(GoRouterState state) =>
      RecipeDetailRoute($extra: state.extra as RecipeDetailArgs?);

  RecipeDetailRoute get _self => this as RecipeDetailRoute;

  @override
  String get location => GoRouteData.$location('/recipes/recipe-detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $RecipeDetailViewRoute on GoRouteData {
  static RecipeDetailViewRoute _fromState(GoRouterState state) =>
      RecipeDetailViewRoute(id: state.pathParameters['id']!);

  RecipeDetailViewRoute get _self => this as RecipeDetailViewRoute;

  @override
  String get location =>
      GoRouteData.$location('/recipes/saved/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
