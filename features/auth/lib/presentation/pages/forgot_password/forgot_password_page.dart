import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_scaffold.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';
import 'widgets/forgot_password_body.dart';

/// Forgot-password screen — a titled header, body with lock icon and email
/// field, and a footer link back to sign-in.
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (ForgotPasswordState p, ForgotPasswordState c) =>
          p.forgotPasswordStatus != c.forgotPasswordStatus,
      listener: _onStateChanged,
      child: AuthScaffold(
        header: const AuthTitledHeader(
          title: 'Reset password',
        ),
        body: const ForgotPasswordBody(),
        footer: Padding(
          padding: const .symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s3,
          ),
          child: GestureDetector(
            onTap: () => context.read<AppNavigator>().goToSignIn(),
            child: Row(
              mainAxisAlignment: .center,
              children: <Widget>[
                const Icon(
                  Icons.chevron_left,
                  color: AppColors.primaryText,
                ),
                Text(
                  'Back to sign in',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ForgotPasswordState state) {
    switch (state.forgotPasswordStatus) {
      case BlocStatus.success:
        context.read<AppNavigator>().pushToForgotPasswordConfirmation(
          state.email!,
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
