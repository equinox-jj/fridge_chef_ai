import 'package:flutter/material.dart';

import '../../utils/validators.dart';

/// A password [TextFormField] that owns its show/hide state internally,
/// rendering a visibility toggle in the suffix. Defaults to [Validators.password].
///
/// Pass [autofillHints] of `[AutofillHints.password]` for sign-in or
/// `[AutofillHints.newPassword]` for registration.
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    required this.controller,
    super.key,
    this.autofillHints = const <String>[AutofillHints.password],
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final List<String> autofillHints;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  void _toggle() => setState(() => _obscure = !_obscure);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      validator: widget.validator ?? Validators.password,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          tooltip: _obscure ? 'Show password' : 'Hide password',
          icon: Icon(
            _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          ),
          onPressed: _toggle,
        ),
      ),
    );
  }
}
