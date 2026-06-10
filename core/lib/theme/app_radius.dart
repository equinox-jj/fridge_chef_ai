import 'package:flutter/widgets.dart';

/// Corner radii. Soft, rounded corners throughout.
///
/// Raw values are exposed alongside ready-made [BorderRadius] helpers.
abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12; // default cards, inputs
  static const double lg = 18; // sheets, large cards
  static const double xl = 26;
  static const double xxl = 34;
  static const double full = 999; // pills, FAB, avatars

  static const BorderRadius brXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius brSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius brMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius brLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius brXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius brXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius brFull = BorderRadius.all(Radius.circular(full));
}

/// Border (stroke) widths.
abstract final class AppBorderWidth {
  static const double hairline = 1;
  static const double thick = 1.5;
}
