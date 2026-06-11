import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'cubit/sign_in_cubit.dart';
import 'cubit/sign_in_state.dart';
import 'widgets/login_hero.dart';
import 'widgets/sign_in_card.dart';

/// Sign-in screen — the green gradient hero with a floating credential card.
///
/// a flexible hero that centers vertically and the
/// card pinned to the bottom of the screen.
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<SignInCubit, SignInState>(
        listenWhen: (SignInState p, SignInState c) => p.signInStatus != c.signInStatus,
        listener: _onStateChanged,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.2, -1),
              end: Alignment(0.2, 1),
              stops: <double>[0, 0.46, 1],
              colors: <Color>[
                AppPalette.green600,
                AppPalette.green800,
                AppPalette.neutral900,
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.s7,
                      AppSpacing.s0,
                      AppSpacing.s7,
                      AppSpacing.s8,
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(child: LoginHero()),
                        SignInCard(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, SignInState state) {
    switch (state.signInStatus) {
      case BlocStatus.success:
        context.read<AppNavigator>().toDashboard();
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.signInFailure?.message ?? '',
        );
        break;
      default:
    }
  }
}
