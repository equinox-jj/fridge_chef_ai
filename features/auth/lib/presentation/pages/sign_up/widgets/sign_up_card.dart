import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/card/app_card.dart';
import 'package:core/components/text/app_inline_link.dart';
import 'package:core/components/text_field/app_email_field.dart';
import 'package:core/components/text_field/app_password_field.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/utils/validators.dart';
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

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.s4),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (SignUpState p, SignUpState c) => p.signUpStatus != c.signUpStatus,
              builder: (BuildContext context, SignUpState state) {
                final bool isLoading = state.signUpStatus == BlocStatus.loading;

                return AppSubmitButton(
                  label: 'Create account',
                  icon: Icons.person_add_alt_1,
                  isLoading: isLoading,
                  onPressed: _submit,
                );
              },
            ),
            const SizedBox(height: AppSpacing.s4),
            AppInlineLink(
              text: 'Already have an account? ',
              linkLabel: 'Sign in',
              onTap: () => context.read<AppNavigator>().toSignIn(),
            ),
          ],
        ),
      ),
    );
  }
}
