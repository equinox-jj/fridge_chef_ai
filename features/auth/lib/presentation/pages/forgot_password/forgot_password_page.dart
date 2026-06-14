import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_scaffold.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/forgot_password_card.dart';

/// Forgot-password screen — the same green gradient hero as sign-in/sign-up,
/// with a single-field card that emails a reset code.
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (ForgotPasswordState p, ForgotPasswordState c) => p.forgotPasswordStatus != c.forgotPasswordStatus,
      listener: _onStateChanged,
      child: const AuthScaffold(card: ForgotPasswordCard()),
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
