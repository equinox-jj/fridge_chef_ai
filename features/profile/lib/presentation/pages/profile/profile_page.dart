import 'package:core/components/button/app_button.dart';
import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (ProfileState p, ProfileState c) => p.signOutStatus != c.signOutStatus,
        listener: _onStateChanged,
        builder: (BuildContext context, ProfileState state) {
          final bool isLoading = state.signOutStatus == BlocStatus.loading;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s6),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  AppButton(
                    label: 'Sign Out',
                    icon: Icons.logout_rounded,
                    variant: AppButtonVariant.danger,
                    block: true,
                    onPressed: isLoading ? null : () => context.read<ProfileCubit>().signOut(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, ProfileState state) {
    switch (state.signOutStatus) {
      case BlocStatus.success:
        context.read<AppNavigator>().toSignIn();
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.signOutFailure?.message ?? '',
        );
        break;
      default:
    }
  }
}
