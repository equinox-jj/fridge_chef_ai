import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/card/app_card.dart';
import 'package:core/components/text/app_inline_link.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:core/utils/validators.dart';
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
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.email],
              validator: Validators.email,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocSelector<SignInCubit, SignInState, bool>(
              selector: (SignInState state) => state.obscurePassword,
              builder: (BuildContext context, bool obscurePassword) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const <String>[AutofillHints.password],
                  validator: Validators.password,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => context.read<SignInCubit>().toggleObscurePassword(),
                    ),
                  ),
                );
              },
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
