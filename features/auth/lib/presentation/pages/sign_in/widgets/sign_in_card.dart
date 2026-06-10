import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_route.dart';
import 'package:core/theme/theme.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
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
  bool _obscurePassword = true;

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

  String? _validateEmail(String? value) {
    final String email = value?.trim() ?? '';
    if (email.isEmpty) return 'Enter your email';
    final bool valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return valid ? null : 'Enter a valid email';
  }

  String? _validatePassword(String? value) {
    if ((value ?? '').isEmpty) return 'Enter your password';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: .all(AppRadius.brXl),
        boxShadow: AppShadows.xl,
      ),
      padding: const .all(AppSpacing.s5),
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
              validator: _validateEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const <String>[AutofillHints.password],
              validator: _validatePassword,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => setState(
                    () => _obscurePassword = !_obscurePassword,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocBuilder<SignInCubit, SignInState>(
              builder: (BuildContext context, SignInState state) {
                final bool isLoading = state is SignInLoading;

                return SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: isLoading ? null : _submit,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                        AppLayout.tapTarget,
                      ),
                    ),
                    icon: isLoading
                        ? const SizedBox.shrink()
                        : const Icon(
                            Icons.login,
                            size: AppTextSize.h3,
                          ),
                    label: isLoading
                        ? const SizedBox(
                            width: AppSpacing.s5,
                            height: AppSpacing.s5,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.onPrimary,
                            ),
                          )
                        : const Text('Sign in'),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.s4),
            Text.rich(
              TextSpan(
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                ),
                children: <InlineSpan>[
                  const TextSpan(text: 'New here? '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () => context.goNamed(AppRoute.signUpName),
                      child: Text(
                        'Create an account',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
