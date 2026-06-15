import 'package:core/components/text/app_inline_link.dart';
import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_scaffold.dart';
import 'cubit/sign_up_cubit.dart';
import 'cubit/sign_up_state.dart';
import 'widgets/sign_up_body.dart';

/// Sign-up screen — scrollable registration form with terms note.
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (SignUpState p, SignUpState c) => p.signUpStatus != c.signUpStatus,
      listener: _onStateChanged,
      child: AuthScaffold(
        header: const AuthBackHeader(),
        body: const SignUpBody(),
        footer: AppInlineLink(
          text: 'Already have an account? ',
          linkLabel: 'Sign in',
          onTap: () => context.read<AppNavigator>().toSignIn(),
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
