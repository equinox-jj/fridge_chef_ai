import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/components/text_field/app_password_field.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/sign_in_cubit.dart';
import '../cubit/sign_in_state.dart';

/// The scrollable body for the sign-in screen.
///
/// Renders a brand mark, heading, inline error banner, credential fields,
/// a forgot-password link, and the submit button.
class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context.unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<SignInCubit>().signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: AppSpacing.s8),

          // Brand mark — 64×64 green gradient tile
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppDarkPalette.green500,
                    AppDarkPalette.green800,
                  ],
                ),
                boxShadow: AppShadows.primary,
              ),
              child: const Icon(
                Icons.kitchen_outlined,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.s3),

          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.s1),
          Text(
            'Sign in to start cooking',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: AppSpacing.s5),

          // Error banner — shown only when signInStatus == BlocStatus.error
          BlocBuilder<SignInCubit, SignInState>(
            buildWhen: (SignInState p, SignInState c) =>
                p.signInStatus != c.signInStatus,
            builder: (BuildContext context, SignInState state) {
              if (state.signInStatus != BlocStatus.error) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.s4),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.dangerTint,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.dangerText,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "That didn't match. Check your details and try again.",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.dangerText,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          AppEmailField(controller: _emailController),
          const SizedBox(height: AppSpacing.s4),
          AppPasswordField(
            controller: _passwordController,
            onFieldSubmitted: (_) => _submit(context),
          ),
          const SizedBox(height: AppSpacing.s2),

          // Forgot password link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.read<AppNavigator>().pushToForgotPassword(),
              child: Text(
                'Forgot password?',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.s4),

          BlocBuilder<SignInCubit, SignInState>(
            buildWhen: (SignInState p, SignInState c) =>
                p.signInStatus != c.signInStatus,
            builder: (BuildContext context, SignInState state) {
              final bool isLoading = state.signInStatus == BlocStatus.loading;

              return AppSubmitButton(
                label: 'Sign in',
                icon: Icons.login,
                isLoading: isLoading,
                onPressed: () => _submit(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
