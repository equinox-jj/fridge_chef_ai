import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/card/app_card.dart';
import 'package:core/components/text/app_inline_link.dart';
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
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
    context.unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<ForgotPasswordCubit>().forgotPassword(
      email: _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
            AppEmailField(
              controller: _emailController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              buildWhen: (ForgotPasswordState p, ForgotPasswordState c) =>
                  p.forgotPasswordStatus != c.forgotPasswordStatus || p.resendCountdown != c.resendCountdown,
              builder: (BuildContext context, ForgotPasswordState state) {
                final bool isLoading = state.forgotPasswordStatus == BlocStatus.loading;
                final bool isCoolingDown = state.resendCountdown > 0;

                return AppSubmitButton(
                  label: isCoolingDown ? 'Resend in ${state.resendCountdown}s' : 'Send reset code',
                  icon: Icons.mark_email_read_outlined,
                  isLoading: isLoading,
                  onPressed: isCoolingDown ? null : _submit,
                );
              },
            ),
            const SizedBox(height: AppSpacing.s4),
            Center(
              child: AppInlineLink(
                text: 'Remember your password? ',
                linkLabel: 'Sign in',
                onTap: () => context.read<AppNavigator>().toSignIn(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
