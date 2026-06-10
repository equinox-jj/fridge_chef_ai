import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/theme.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/sign_up_cubit.dart';
import '../cubit/sign_up_state.dart';

/// The floating white card holding the registration form.
///
/// Mirrors the sign-in card with an extra name field: name + email + password,
/// a full-width primary action and the "sign in" link.
class SignUpCard extends StatefulWidget {
  const SignUpCard({super.key});

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SignUpCubit>().signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  String? _validateName(String? value) {
    if ((value?.trim() ?? '').isEmpty) return 'Enter your name';
    return null;
  }

  String? _validateEmail(String? value) {
    final String email = value?.trim() ?? '';
    if (email.isEmpty) return 'Enter your email';
    final bool valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return valid ? null : 'Enter a valid email';
  }

  String? _validatePassword(String? value) {
    final String password = value ?? '';
    if (password.isEmpty) return 'Enter a password';
    if (password.length < 6) return 'At least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.all(AppRadius.brXl),
        boxShadow: AppShadows.xl,
      ),
      padding: const EdgeInsets.all(AppSpacing.s5),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.name],
              validator: _validateName,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Jane Doe',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
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
            BlocSelector<SignUpCubit, SignUpState, bool>(
              selector: (SignUpState state) => state.obscurePassword,
              builder: (BuildContext context, bool obscurePassword) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const <String>[AutofillHints.newPassword],
                  validator: _validatePassword,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => context.read<SignUpCubit>().toggleObscurePassword(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (SignUpState p, SignUpState c) => p.signUpStatus != c.signUpStatus,
              builder: (BuildContext context, SignUpState state) {
                final bool isLoading = state.signUpStatus == BlocStatus.loading;

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
                            Icons.person_add_alt_1,
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
                        : const Text('Create account'),
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
                  const TextSpan(text: 'Already have an account? '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () => context.read<AppNavigator>().toSignIn(),
                      child: Text(
                        'Sign in',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
