import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme => TextTheme.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
