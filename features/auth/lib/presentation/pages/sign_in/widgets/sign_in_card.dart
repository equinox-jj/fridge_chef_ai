import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/card/app_card.dart';
import 'package:core/components/text/app_inline_link.dart';
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/components/text_field/app_password_field.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/sign_in_cubit.dart';
import '../cubit/sign_in_state.dart';

/// The floating white card holding the credential form.
///
/// Mirrors `.fs-login__card`: email + password fields, a full-width primary
/// action and the "create an account" link.
class SignInCard extends StatefulWidget {
  const SignInCard({super.key});

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<SignInCubit>().signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppEmailField(controller: _emailController),
            const SizedBox(height: AppSpacing.s4),
            AppPasswordField(
              controller: _passwordController,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.s2),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => context.read<AppNavigator>().toForgotPassword(),
                child: Text(
                  'Forgot password?',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocBuilder<SignInCubit, SignInState>(
              buildWhen: (SignInState p, SignInState c) => p.signInStatus != c.signInStatus,
              builder: (BuildContext context, SignInState state) {
                final bool isLoading = state.signInStatus == BlocStatus.loading;

                return AppSubmitButton(
                  label: 'Sign in',
                  icon: Icons.login,
                  isLoading: isLoading,
                  onPressed: _submit,
                );
              },
            ),
            const SizedBox(height: AppSpacing.s4),
            AppInlineLink(
              text: 'New here? ',
              linkLabel: 'Create an account',
              onTap: () => context.read<AppNavigator>().toSignUp(),
            ),
          ],
        ),
      ),
    );
  }
}
