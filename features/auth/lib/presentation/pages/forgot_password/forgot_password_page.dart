import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/theme/theme.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../sign_in/widgets/login_hero.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/forgot_password_card.dart';

/// Forgot-password screen — the same green gradient hero as sign-in/sign-up,
/// with a single-field card that emails a reset code.
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (ForgotPasswordState p, ForgotPasswordState c) => p.forgotPasswordStatus != c.forgotPasswordStatus,
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
                        ForgotPasswordCard(),
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

  void _onStateChanged(BuildContext context, ForgotPasswordState state) {
    switch (state.forgotPasswordStatus) {
      case BlocStatus.success:
        AppSnackbar.success(
          context,
          'We\'ve sent a reset code to your email.',
        );
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.forgotPasswordFailure?.message ?? '',
        );
        break;
      default:
    }
  }
}
