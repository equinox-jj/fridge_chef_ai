import 'package:flutter/material.dart';

import '../../utils/validators.dart';

/// A pre-configured email [TextFormField]: email keyboard, email autofill, the
/// standard mail-icon decoration and [Validators.email] by default.
class AppEmailField extends StatelessWidget {
  const AppEmailField({
    required this.controller,
    super.key,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.email],
      validator: validator ?? Validators.email,
      onFieldSubmitted: onFieldSubmitted,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'you@example.com',
        prefixIcon: Icon(Icons.mail_outline),
      ),
    );
  }
}
