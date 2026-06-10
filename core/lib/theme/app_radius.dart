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

  static const Radius brXs = Radius.circular(xs);
  static const Radius brSm = Radius.circular(sm);
  static const Radius brMd = Radius.circular(md);
  static const Radius brLg = Radius.circular(lg);
  static const Radius brXl = Radius.circular(xl);
  static const Radius brXxl = Radius.circular(xxl);
  static const Radius brFull = Radius.circular(full);
}

/// Border (stroke) widths.
abstract final class AppBorderWidth {
  static const double hairline = 1;
  static const double thick = 1.5;
}
