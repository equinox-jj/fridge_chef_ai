import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme => TextTheme.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  ColorScheme get colorScheme => ColorScheme.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
