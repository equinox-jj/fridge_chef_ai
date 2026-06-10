import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/theme.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../sign_in/widgets/login_hero.dart';
import 'cubit/sign_up_cubit.dart';
import 'cubit/sign_up_state.dart';
import 'widgets/sign_up_card.dart';

/// Sign-up screen — the green gradient hero with a floating registration card.
///
/// a flexible hero that centers vertically and the
/// card pinned to the bottom of the screen.
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (SignUpState p, SignUpState c) => p.signUpStatus != c.signUpStatus,
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
                        SignUpCard(),
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

  void _onStateChanged(BuildContext context, SignUpState state) {
    switch (state.signUpStatus) {
      case BlocStatus.success:
        context.read<AppNavigator>().toDashboard();
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.signUpFailure?.message ?? '',
        );
        break;
      default:
    }
  }
}
