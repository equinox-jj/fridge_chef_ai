import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_family.dart';

/// Font weights from the design tokens.
abstract final class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extra = FontWeight.w800;
}

/// Mobile-first type scale (font sizes in logical pixels).
abstract final class AppTextSize {
  static const double display = 34; // hero numerals, big titles
  static const double h1 = 27; // screen titles, recipe names
  static const double h2 = 22;
  static const double h3 = 18;
  static const double lg = 17; // prominent body
  static const double base = 15; // default body
  static const double sm = 13; // secondary, captions
  static const double xs = 11; // labels, badges
  static const double micro = 10; // eyebrow / overline
}

/// Line-height multipliers from the design tokens.
abstract final class AppLineHeight {
  static const double tight = 1.1;
  static const double snug = 1.25;
  static const double normal = 1.45;
  static const double relaxed = 1.6;
}

/// Base typography for the app, derived from the design tokens.
///
/// Display and headings use [AppFontFamily.display] (Bricolage Grotesque);
/// titles, body and labels use [AppFontFamily.body] (Plus Jakarta Sans).
/// Use [mono] for code, numbers and tabular data.
///
/// The scale maps the product tokens onto Material 3 [TextTheme] roles, so it
/// plugs straight into `ThemeData(textTheme: AppTypography.textTheme)`. Letter
/// spacing follows the `--tracking-*` tokens (em × font size).
abstract final class AppTypography {
  /// Material 3 text theme built from the FridgeScan type scale.
  static const TextTheme textTheme = TextTheme(
    // Display — Bricolage Grotesque, tight tracking.
    displayLarge: TextStyle(
      fontFamily: AppFontFamily.display,
      fontSize: AppTextSize.display, // 34
      height: AppLineHeight.tight,
      letterSpacing: -0.68, // -0.02em
      fontWeight: AppFontWeight.extra,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFontFamily.display,
      fontSize: AppTextSize.h1, // 27
      height: AppLineHeight.tight,
      letterSpacing: -0.54,
      fontWeight: AppFontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFontFamily.display,
      fontSize: AppTextSize.h2, // 22
      height: AppLineHeight.snug,
      letterSpacing: -0.44,
      fontWeight: AppFontWeight.bold,
    ),
    // Headline — Bricolage Grotesque.
    headlineLarge: TextStyle(
      fontFamily: AppFontFamily.display,
      fontSize: AppTextSize.h2, // 22
      height: AppLineHeight.snug,
      letterSpacing: -0.44,
      fontWeight: AppFontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: AppFontFamily.display,
      fontSize: AppTextSize.h3, // 18
      height: AppLineHeight.snug,
      letterSpacing: -0.36,
      fontWeight: AppFontWeight.semiBold,
    ),
    headlineSmall: TextStyle(
      fontFamily: AppFontFamily.display,
      fontSize: AppTextSize.lg, // 17
      height: AppLineHeight.snug,
      letterSpacing: -0.34,
      fontWeight: AppFontWeight.semiBold,
    ),
    // Title — Plus Jakarta Sans.
    titleLarge: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.h3, // 18
      height: AppLineHeight.snug,
      fontWeight: AppFontWeight.semiBold,
    ),
    titleMedium: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.base, // 15
      height: AppLineHeight.normal,
      fontWeight: AppFontWeight.semiBold,
    ),
    titleSmall: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.sm, // 13
      height: AppLineHeight.normal,
      fontWeight: AppFontWeight.semiBold,
    ),
    // Body — Plus Jakarta Sans.
    bodyLarge: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.lg, // 17
      height: AppLineHeight.relaxed,
      fontWeight: AppFontWeight.regular,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.base, // 15
      height: AppLineHeight.normal,
      fontWeight: AppFontWeight.regular,
    ),
    bodySmall: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.sm, // 13
      height: AppLineHeight.normal,
      fontWeight: AppFontWeight.regular,
    ),
    // Label — Plus Jakarta Sans.
    labelLarge: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.sm, // 13
      height: AppLineHeight.snug,
      fontWeight: AppFontWeight.medium,
    ),
    labelMedium: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.xs, // 11
      height: AppLineHeight.snug,
      letterSpacing: 0.44, // 0.04em wide
      fontWeight: AppFontWeight.medium,
    ),
    labelSmall: TextStyle(
      fontFamily: AppFontFamily.body,
      fontSize: AppTextSize.micro, // 10 — eyebrow / overline
      height: AppLineHeight.tight,
      letterSpacing: 0.8, // 0.08em
      fontWeight: AppFontWeight.semiBold,
    ),
  );

  /// Monospace style ([AppFontFamily.mono]) for code, numbers and tabular data.
  static const TextStyle mono = TextStyle(
    fontFamily: AppFontFamily.mono,
    fontSize: AppTextSize.base,
    height: AppLineHeight.normal,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textBody,
  );
}
