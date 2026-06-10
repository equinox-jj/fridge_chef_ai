import 'package:flutter/animation.dart';

/// Animation durations and easing curves.
abstract final class AppMotion {
  // ---- Durations ----
  static const Duration fast = Duration(milliseconds: 140);
  static const Duration base = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 360);

  // ---- Curves ----
  static const Curve easeOut = Cubic(0.22, 1, 0.36, 1);
  static const Curve easeInOut = Cubic(0.45, 0, 0.2, 1);
  static const Curve easeSpring = Cubic(0.34, 1.56, 0.64, 1);
}
