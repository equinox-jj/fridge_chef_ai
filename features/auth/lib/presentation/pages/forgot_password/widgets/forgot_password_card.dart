import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/theme.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';

/// The floating white card holding the reset-code form.
///
/// A single email field plus a send button that doubles as the resend control:
/// once a code is sent it is disabled for a 60-second cooldown, counting down
/// in its label. Below sits the "back to sign in" link.
class ForgotPasswordCard extends StatefulWidget {
  const ForgotPasswordCard({super.key});

  @override
  State<ForgotPasswordCard> createState() => _ForgotPasswordCardState();
}

class _ForgotPasswordCardState extends State<ForgotPasswordCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<ForgotPasswordCubit>().forgotPassword(
      email: _emailController.text.trim(),
    );
  }

  String? _validateEmail(String? value) {
    final String email = value?.trim() ?? '';
    if (email.isEmpty) return 'Enter your email';
    final bool valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return valid ? null : 'Enter a valid email';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reset your password',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: AppFontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.s1),
            Text(
              "Enter your email and we'll send you a code to reset your "
              'password.',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const <String>[AutofillHints.email],
              validator: _validateEmail,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              buildWhen: (ForgotPasswordState p, ForgotPasswordState c) =>
                  p.forgotPasswordStatus != c.forgotPasswordStatus || p.resendCountdown != c.resendCountdown,
              builder: (BuildContext context, ForgotPasswordState state) {
                final bool isLoading = state.forgotPasswordStatus == BlocStatus.loading;
                final bool isCoolingDown = state.resendCountdown > 0;

                return SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: isLoading || isCoolingDown ? null : _submit,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                        AppLayout.tapTarget,
                      ),
                    ),
                    icon: isLoading
                        ? const SizedBox.shrink()
                        : const Icon(
                            Icons.mark_email_read_outlined,
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
                        : Text(
                            isCoolingDown ? 'Resend in ${state.resendCountdown}s' : 'Send reset code',
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.s4),
            Center(
              child: Text.rich(
                TextSpan(
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Remember your password? '),
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
            ),
          ],
        ),
      ),
    );
  }
}
