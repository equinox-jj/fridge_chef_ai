import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_scaffold.dart';
import 'cubit/sign_in_cubit.dart';
import 'cubit/sign_in_state.dart';
import 'widgets/sign_in_card.dart';

/// Sign-in screen — the green gradient hero with a floating credential card.
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (SignInState p, SignInState c) => p.signInStatus != c.signInStatus,
      listener: _onStateChanged,
      child: const AuthScaffold(card: SignInCard()),
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
