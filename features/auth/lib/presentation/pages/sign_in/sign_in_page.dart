import 'package:core/components/text/app_inline_link.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_scaffold.dart';
import 'cubit/sign_in_cubit.dart';
import 'cubit/sign_in_state.dart';
import 'widgets/sign_in_body.dart';

/// Sign-in screen — scrollable credential form with inline error banner.
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (SignInState p, SignInState c) =>
          p.signInStatus != c.signInStatus,
      listener: _onStateChanged,
      child: AuthScaffold(
        body: const SignInBody(),
        footer: AppInlineLink(
          text: 'New here? ',
          linkLabel: 'Create an account',
          onTap: () => context.read<AppNavigator>().pushToSignUp(),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, SignInState state) {
    switch (state.signInStatus) {
      case BlocStatus.success:
        context.read<AppNavigator>().goToDashboard();
        break;
      default:
    }
  }
}
