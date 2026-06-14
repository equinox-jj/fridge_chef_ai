import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth_scaffold.dart';
import 'cubit/sign_up_cubit.dart';
import 'cubit/sign_up_state.dart';
import 'widgets/sign_up_card.dart';

/// Sign-up screen — the green gradient hero with a floating registration card.
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (SignUpState p, SignUpState c) => p.signUpStatus != c.signUpStatus,
      listener: _onStateChanged,
      child: const AuthScaffold(card: SignUpCard()),
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
