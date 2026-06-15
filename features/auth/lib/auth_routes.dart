import 'package:core/di/di.dart';
import 'package:core/router/app_route.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/widgets.dart';

import 'presentation/pages/forgot_password/cubit/forgot_password_cubit.dart';
import 'presentation/pages/forgot_password/forgot_password_confirmation_page.dart';
import 'presentation/pages/forgot_password/forgot_password_page.dart';
import 'presentation/pages/sign_in/cubit/sign_in_cubit.dart';
import 'presentation/pages/sign_in/sign_in_page.dart';
import 'presentation/pages/sign_up/cubit/sign_up_cubit.dart';
import 'presentation/pages/sign_up/sign_up_page.dart';

part 'auth_routes.g.dart';

List<RouteBase> get authRoutes => $appRoutes;

@TypedGoRoute<SignInRoute>(
  path: AppRoute.signInPath,
  name: AppRoute.signInName,
)
class SignInRoute extends GoRouteData with $SignInRoute {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SignInCubit>(
      create: (_) => getIt<SignInCubit>(),
      child: const SignInPage(),
    );
  }
}

@TypedGoRoute<SignUpRoute>(
  path: AppRoute.signUpPath,
  name: AppRoute.signUpName,
)
class SignUpRoute extends GoRouteData with $SignUpRoute {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SignUpCubit>(
      create: (_) => getIt<SignUpCubit>(),
      child: const SignUpPage(),
    );
  }
}

@TypedGoRoute<ForgotPasswordRoute>(
  path: AppRoute.forgotPasswordPath,
  name: AppRoute.forgotPasswordName,
)
class ForgotPasswordRoute extends GoRouteData with $ForgotPasswordRoute {
  const ForgotPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => getIt<ForgotPasswordCubit>(),
      child: const ForgotPasswordPage(),
    );
  }
}

@TypedGoRoute<ForgotPasswordConfirmationRoute>(
  path: AppRoute.forgotPasswordConfirmationPath,
  name: AppRoute.forgotPasswordConfirmationName,
)
class ForgotPasswordConfirmationRoute extends GoRouteData
    with $ForgotPasswordConfirmationRoute {
  const ForgotPasswordConfirmationRoute({required this.email});

  final String email;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => getIt<ForgotPasswordCubit>(),
      child: ForgotPasswordConfirmationPage(email: email),
    );
  }
}
