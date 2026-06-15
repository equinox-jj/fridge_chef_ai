import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/components/text_field/app_password_field.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/utils/validators.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../cubit/sign_up_cubit.dart';
import '../cubit/sign_up_state.dart';

/// The scrollable body for the sign-up screen.
///
/// Renders a heading, subtitle, name + email + password fields,
/// a submit button, and a terms-of-service note.
class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
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

  void _submit(BuildContext context) {
    context.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SignUpCubit>().signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: AppSpacing.s5),

          Text(
            'Create your account',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: AppSpacing.s1),
          Text(
            'Free to start — 15 scans a day.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: AppSpacing.s5),

          // Name field
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            autofillHints: const <String>[AutofillHints.name],
            validator: (String? value) => Validators.required(
              value,
              'Enter your name',
            ),
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Jane Doe',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),

          const SizedBox(height: AppSpacing.s4),
          AppEmailField(controller: _emailController),
          const SizedBox(height: AppSpacing.s4),
          AppPasswordField(
            controller: _passwordController,
            autofillHints: const <String>[AutofillHints.newPassword],
            onFieldSubmitted: (_) => _submit(context),
          ),
          const SizedBox(height: AppSpacing.s4),

          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.signUpStatus != c.signUpStatus,
            builder: (BuildContext context, SignUpState state) {
              final bool isLoading = state.signUpStatus == BlocStatus.loading;

              return AppSubmitButton(
                label: 'Create account',
                icon: Icons.person_add_alt_1,
                isLoading: isLoading,
                onPressed: () => _submit(context),
              );
            },
          ),

          const SizedBox(height: AppSpacing.s3),

          SizedBox(
            width: double.infinity,
            child: Text(
              'By continuing you agree to our Terms and Privacy Policy.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textFaint,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
