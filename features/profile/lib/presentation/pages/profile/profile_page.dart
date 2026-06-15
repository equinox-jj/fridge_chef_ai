import 'package:core/components/dialog/app_confirm_dialog.dart';
import 'package:core/components/image_source_sheet/pick_image_source_sheet.dart';
import 'package:core/components/list_row/app_list_row.dart';
import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/image_source_option/image_source_option.dart';
import 'package:core/constants/image_source_option/photo_source_choice.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/skeletonizer/skeletonizer.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/profile_entity.dart';
import '../../widgets/dietary_preference_sheet.dart';
import '../../widgets/profile_group.dart';
import 'cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _editDietaryPreference(
    BuildContext context,
    DietaryPreference current,
  ) async {
    final ProfileCubit cubit = context.read<ProfileCubit>();
    final DietaryPreference? chosen = await DietaryPreferenceSheet.openSheet(
      context,
      current: current,
    );
    if (chosen != null && chosen != current) {
      await cubit.updateDietaryPreference(chosen);
    }
  }

  Future<void> _editAvatar(
    BuildContext context, {
    required bool hasAvatar,
  }) async {
    final ProfileCubit cubit = context.read<ProfileCubit>();
    final PhotoSourceChoice? choice = await PickImageSourceSheet.openSheet(
      context,
      title: 'Profile photo',
      showRemove: hasAvatar,
    );
    if (choice == null) return;
    if (choice == PhotoSourceChoice.remove) {
      await cubit.removeAvatar();
      return;
    }
    final ImageSourceOption? source = choice.imageSource;
    if (source != null) {
      await cubit.changeAvatar(source);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final ProfileCubit cubit = context.read<ProfileCubit>();
    final bool confirmed = await AppConfirmDialog.show(
      context,
      title: 'Sign out?',
      message: "You'll need to sign in again to use your account.",
      confirmLabel: 'Sign out',
      isDestructive: true,
    );
    if (confirmed) {
      cubit.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.s4,
        title: Text(
          'Profile',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (ProfileState p, ProfileState c) =>
            p.signOutStatus != c.signOutStatus ||
            p.dietaryStatus != c.dietaryStatus ||
            p.avatarStatus != c.avatarStatus,
        listener: _onStateChanged,
        builder: (BuildContext context, ProfileState state) {
          final bool isLoading = state.loadStatus == BlocStatus.loading;
          return SafeArea(
            child: Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s5,
                  AppSpacing.s2,
                  AppSpacing.s5,
                  AppSpacing.s8,
                ),
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: AppSpacing.s6,
                  children: <Widget>[
                    _ProfileHeader(
                      profile: state.profile,
                      isUpdating: state.avatarStatus == BlocStatus.loading,
                      onEditTap: () => _editAvatar(
                        context,
                        hasAvatar:
                            state.profile?.avatarUrl?.isNotEmpty ?? false,
                      ),
                    ),
                    ProfileGroup(
                      label: 'Preferences',
                      rows: <Widget>[
                        AppListRow(
                          icon: Icons.restaurant_menu_rounded,
                          title: 'Dietary preference',
                          value: state.dietaryPreference.label,
                          onTap: () => _editDietaryPreference(
                            context,
                            state.dietaryPreference,
                          ),
                        ),
                        AppListRow(
                          icon: Icons.history_rounded,
                          tone: AppListRowTone.blue,
                          title: 'Scan history',
                          value: state.scanCount == null
                              ? null
                              : '${state.scanCount} scans',
                          onTap: () =>
                              context.read<AppNavigator>().pushToScanHistory(),
                        ),
                      ],
                    ),
                    ProfileGroup(
                      label: 'Account',
                      rows: <Widget>[
                        AppListRow(
                          icon: Icons.notifications_none_rounded,
                          title: 'Notifications',
                          onTap: () => AppSnackbar.info(context, 'Coming soon'),
                        ),
                        AppListRow(
                          icon: Icons.help_outline_rounded,
                          title: 'Help & feedback',
                          onTap: () => AppSnackbar.info(context, 'Coming soon'),
                        ),
                        AppListRow(
                          icon: Icons.logout_rounded,
                          title: 'Sign out',
                          isDestructive: true,
                          onTap: state.signOutStatus == BlocStatus.loading
                              ? null
                              : () => _confirmSignOut(context),
                        ),
                      ],
                    ),
                  ],
                ),
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
        context.read<AppNavigator>().goToSignIn();
        return;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.signOutFailure?.message ?? 'Could not sign out.',
        );
        break;
      default:
        break;
    }

    switch (state.dietaryStatus) {
      case BlocStatus.success:
        AppSnackbar.success(context, 'Dietary preference updated.');
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.dietaryFailure?.message ?? 'Could not update preference.',
        );
        break;
      default:
        break;
    }

    switch (state.avatarStatus) {
      case BlocStatus.success:
        AppSnackbar.success(context, 'Profile photo updated.');
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.avatarFailure?.message ?? 'Could not update your photo.',
        );
        break;
      default:
        break;
    }
  }
}

/// The avatar, name and email block at the top of the profile (design 4.1).
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.profile,
    required this.isUpdating,
    required this.onEditTap,
  });

  final ProfileEntity? profile;
  final bool isUpdating;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final String name = (profile?.name?.trim().isNotEmpty ?? false)
        ? profile!.name!.trim()
        : 'There';
    final String? email = profile?.email;
    final String? avatarUrl = profile?.avatarUrl;

    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CircleAvatar(
              radius: AppSpacing.s9, // 48
              backgroundColor: AppColors.primaryTint,
              foregroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                  ? NetworkImage(avatarUrl)
                  : null,
              child: Text(
                name.characters.first.toUpperCase(),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontFamily: AppFontFamily.display,
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            if (isUpdating)
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0x66000000),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: isUpdating ? null : onEditTap,
                  child: const Padding(
                    padding: EdgeInsets.all(AppSpacing.s2),
                    child: Icon(
                      Icons.photo_camera_rounded,
                      size: 16,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s3),
        Text(
          name,
          style: context.textTheme.headlineSmall?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        if (email != null && email.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppSpacing.s1),
          Text(
            email,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}
