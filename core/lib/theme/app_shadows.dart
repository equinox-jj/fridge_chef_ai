import 'package:flutter/widgets.dart';

/// Elevation shadows — deepened for dark warm surfaces.
///
/// Each token is a list of [BoxShadow] suitable for use on dark card/canvas.
abstract final class AppShadows {
  static const List<BoxShadow> xs = <BoxShadow>[
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> sm = <BoxShadow>[
    BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> md = <BoxShadow>[
    BoxShadow(
      color: Color(0x40000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> lg = <BoxShadow>[
    BoxShadow(
      color: Color(0x59000000),
      offset: Offset(0, 12),
      blurRadius: 28,
    ),
    BoxShadow(
      color: Color(0x26000000),
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> xl = <BoxShadow>[
    BoxShadow(
      color: Color(0x73000000),
      offset: Offset(0, 24),
      blurRadius: 48,
    ),
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 8),
      blurRadius: 16,
    ),
  ];

  /// Colored "glow" for the primary FAB.
  static const List<BoxShadow> primary = <BoxShadow>[
    BoxShadow(
      color: Color(0x47138062), // primary @ 0.28
      offset: Offset(0, 8),
      blurRadius: 20,
    ),
  ];

  /// Colored "glow" for AI / Gemini moments.
  static const List<BoxShadow> ai = <BoxShadow>[
    BoxShadow(
      color: Color(0x425F56C4), // ai purple @ 0.26
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];
}
