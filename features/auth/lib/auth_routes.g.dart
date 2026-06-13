// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $signInRoute,
  $signUpRoute,
  $forgotPasswordRoute,
];

RouteBase get $signInRoute => GoRouteData.$route(
  path: '/sign-in',
  name: 'signIn',
  factory: $SignInRoute._fromState,
);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  @override
  String get location => GoRouteData.$location('/sign-in');

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

RouteBase get $signUpRoute => GoRouteData.$route(
  path: '/sign-up',
  name: 'signUp',
  factory: $SignUpRoute._fromState,
);

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  @override
  String get location => GoRouteData.$location('/sign-up');

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

RouteBase get $forgotPasswordRoute => GoRouteData.$route(
  path: '/forgot-password',
  name: 'forgotPassword',
  factory: $ForgotPasswordRoute._fromState,
);

mixin $ForgotPasswordRoute on GoRouteData {
  static ForgotPasswordRoute _fromState(GoRouterState state) =>
      const ForgotPasswordRoute();

  @override
  String get location => GoRouteData.$location('/forgot-password');

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
