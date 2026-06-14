import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme => TextTheme.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  ColorScheme get colorScheme => ColorScheme.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Dismisses the on-screen keyboard by dropping the current focus.
  void unfocus() => FocusScope.of(this).unfocus();

  /// Pops the top route if one can be popped, returning whether it did.
  Future<bool> maybePop<T>([T? result]) => Navigator.of(this).maybePop<T>(result);
}
