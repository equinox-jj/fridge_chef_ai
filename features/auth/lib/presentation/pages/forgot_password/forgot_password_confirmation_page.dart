import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../../../../auth_routes.dart';
import 'cubit/forgot_password_cubit.dart';
import 'cubit/forgot_password_state.dart';

/// Confirmation screen shown after the password-reset email is dispatched.
///
/// Receives the [email] address so it can display it in the body copy and
/// re-trigger [ForgotPasswordCubit.forgotPassword] for the resend flow.
/// The cubit is provided by [ForgotPasswordConfirmationRoute.build] — this
/// widget does **not** create it.
class ForgotPasswordConfirmationPage extends StatelessWidget {
  const ForgotPasswordConfirmationPage({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Mail icon circle
                Container(
                  width: 92,
                  height: 92,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryTint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mail_outline,
                    size: 42,
                    color: AppColors.primaryText,
                  ),
                ),

                const SizedBox(height: AppSpacing.s5),

                Text(
                  'Check your email',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.s2),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: 'We sent a reset link to '),
                      TextSpan(
                        text: email,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textBody,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: '. It expires in 30 minutes.'),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.s6),

                // Open mail app button (filled)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open mail app'),
                    onPressed: () => launchUrl(Uri.parse('mailto:')),
                  ),
                ),

                const SizedBox(height: AppSpacing.s3),

                // Back to sign in (outlined)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to sign in'),
                    onPressed: () => const SignInRoute().go(context),
                  ),
                ),

                const SizedBox(height: AppSpacing.s4),

                // Resend link with cooldown
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (BuildContext context, ForgotPasswordState state) {
                    final bool isCooling = state.resendCountdown > 0;
                    return GestureDetector(
                      onTap: isCooling
                          ? null
                          : () => context
                                .read<ForgotPasswordCubit>()
                                .forgotPassword(email: email),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Didn't get it? ",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textMuted),
                            ),
                            TextSpan(
                              text: isCooling
                                  ? 'Resend in ${state.resendCountdown}s'
                                  : 'Resend',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: isCooling
                                        ? AppColors.textFaint
                                        : AppColors.primaryText,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.s4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
