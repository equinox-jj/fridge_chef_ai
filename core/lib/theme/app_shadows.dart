import 'package:flutter/widgets.dart';

/// Soft, warm-tinted elevation shadows (tinted with neutral-900, never harsh).
///
/// Each token is a list of [BoxShadow] matching the CSS layered shadows.
abstract final class AppShadows {
  static const List<BoxShadow> xs = <BoxShadow>[
    BoxShadow(
      color: Color(0x0D15140F), // rgba(21,20,15,0.05)
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> sm = <BoxShadow>[
    BoxShadow(
      color: Color(0x0F15140F), // 0.06
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Color(0x0A15140F), // 0.04
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> md = <BoxShadow>[
    BoxShadow(
      color: Color(0x1215140F), // 0.07
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
    BoxShadow(
      color: Color(0x0A15140F), // 0.04
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> lg = <BoxShadow>[
    BoxShadow(
      color: Color(0x1A15140F), // 0.10
      offset: Offset(0, 12),
      blurRadius: 28,
    ),
    BoxShadow(
      color: Color(0x0D15140F), // 0.05
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> xl = <BoxShadow>[
    BoxShadow(
      color: Color(0x2415140F), // 0.14
      offset: Offset(0, 24),
      blurRadius: 48,
    ),
    BoxShadow(
      color: Color(0x0F15140F), // 0.06
      offset: Offset(0, 8),
      blurRadius: 16,
    ),
  ];

  /// Colored "glow" for the primary FAB.
  static const List<BoxShadow> primary = <BoxShadow>[
    BoxShadow(
      color: Color(0x470F6E56), // green-600 @ 0.28
      offset: Offset(0, 8),
      blurRadius: 20,
    ),
  ];

  /// Colored "glow" for AI / Gemini moments.
  static const List<BoxShadow> ai = <BoxShadow>[
    BoxShadow(
      color: Color(0x42534AB7), // purple-500 @ 0.26
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];
}
