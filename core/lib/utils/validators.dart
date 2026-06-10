/// Reusable `TextFormField` validators shared across feature forms.
///
/// Each method returns `null` when the value is valid, or an error message to
/// display otherwise — matching the `FormFieldValidator<String>` signature:
///
/// ```dart
/// TextFormField(validator: Validators.email);
/// TextFormField(validator: (v) => Validators.required(v, 'Enter your name'));
/// ```
abstract final class Validators {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Requires a non-empty, well-formed email address.
  static String? email(
    String? value, {
    String emptyMessage = 'Enter your email',
    String invalidMessage = 'Enter a valid email',
  }) {
    final String email = value?.trim() ?? '';
    if (email.isEmpty) return emptyMessage;
    return _emailPattern.hasMatch(email) ? null : invalidMessage;
  }

  /// Requires a non-empty value, reporting [message] when missing.
  ///
  /// Whitespace is trimmed before the emptiness check unless [trim] is `false`.
  static String? required(
    String? value,
    String message, {
    bool trim = true,
  }) {
    final String input = trim ? (value?.trim() ?? '') : (value ?? '');
    return input.isEmpty ? message : null;
  }

  /// Requires a password of at least [minLength] characters.
  static String? password(
    String? value, {
    int minLength = 6,
    String emptyMessage = 'Enter a password',
    String? shortMessage,
  }) {
    final String password = value ?? '';
    if (password.isEmpty) return emptyMessage;
    if (password.length < minLength) {
      return shortMessage ?? 'At least $minLength characters';
    }
    return null;
  }
}
