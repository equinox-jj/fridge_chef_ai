import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';

/// The scrollable body for the forgot-password screen.
///
/// Shows a lock icon tile, heading, subtitle, email field, and a submit
/// button whose label reflects the resend-cooldown countdown.
class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    context.unfocus();
    context.read<ForgotPasswordCubit>().forgotPassword(
      email: _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: <Widget>[
        const SizedBox(height: AppSpacing.s5),
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              borderRadius: .circular(24),
            ),
            child: const Icon(
              Icons.lock_outline,
              size: 38,
              color: AppColors.primaryText,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        Text(
          'Forgot your password?',
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s2),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 240),
            child: Text(
              "Enter your email and we'll send a link to reset it.",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        AppEmailField(
          controller: _emailController,
          onFieldSubmitted: (_) => _submit(context),
        ),
        const SizedBox(height: AppSpacing.s4),
        BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          buildWhen: (ForgotPasswordState p, ForgotPasswordState c) =>
              p.forgotPasswordStatus != c.forgotPasswordStatus ||
              p.resendCountdown != c.resendCountdown,
          builder: (BuildContext context, ForgotPasswordState state) {
            final bool isCoolingDown = state.resendCountdown > 0;
            final bool isLoading =
                state.forgotPasswordStatus == BlocStatus.loading;

            return AppSubmitButton(
              label: isCoolingDown
                  ? 'Resend in ${state.resendCountdown}s'
                  : 'Send reset link',
              icon: Icons.mark_email_read_outlined,
              isLoading: isLoading,
              onPressed: isCoolingDown ? null : () => _submit(context),
            );
          },
        ),
      ],
    );
  }
}
