// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fridge_scan_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$fridgeScanRoute];

RouteBase get $fridgeScanRoute => GoRouteData.$route(
  path: '/fridge-scan',
  name: 'fridgeScan',
  factory: $FridgeScanRoute._fromState,
);

mixin $FridgeScanRoute on GoRouteData {
  static FridgeScanRoute _fromState(GoRouterState state) =>
      const FridgeScanRoute();

  @override
  String get location => GoRouteData.$location('/fridge-scan');

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
