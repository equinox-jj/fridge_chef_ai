// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fridge_scan_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$homeRoute];

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/home',
  name: 'home',
  factory: $HomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'fridge-scan',
      name: 'fridgeScan',
      parentNavigatorKey: FridgeScanRoute.$parentNavigatorKey,
      factory: $FridgeScanRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'ingredient-review',
      name: 'ingredientReview',
      parentNavigatorKey: IngredientReviewRoute.$parentNavigatorKey,
      factory: $IngredientReviewRoute._fromState,
    ),
  ],
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

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

mixin $FridgeScanRoute on GoRouteData {
  static FridgeScanRoute _fromState(GoRouterState state) =>
      const FridgeScanRoute();

  @override
  String get location => GoRouteData.$location('/home/fridge-scan');

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

mixin $IngredientReviewRoute on GoRouteData {
  static IngredientReviewRoute _fromState(GoRouterState state) =>
      IngredientReviewRoute($extra: state.extra as ScanResultEntity);

  IngredientReviewRoute get _self => this as IngredientReviewRoute;

  @override
  String get location => GoRouteData.$location('/home/ingredient-review');

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
