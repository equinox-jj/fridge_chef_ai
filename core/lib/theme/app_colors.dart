import 'package:flutter/material.dart';

/// Raw light color palette — base tokens from the design system CSS.
///
/// Use [AppColors] (dark semantic aliases) or [AppPalette] by name for one-off
/// light-mode overrides. Prefer semantic names in product code.
abstract final class AppPalette {
  // ---- Brand green (fresh produce, primary) ----
  static const Color green50 = Color(0xFFE1F5EE);
  static const Color green100 = Color(0xFFC4EBDD);
  static const Color green200 = Color(0xFF95DBC1);
  static const Color green300 = Color(0xFF5FC6A3);
  static const Color green400 = Color(0xFF2BA17C);
  static const Color green500 = Color(0xFF138062);
  static const Color green600 = Color(0xFF0F6E56); // primary
  static const Color green700 = Color(0xFF0C5644);
  static const Color green800 = Color(0xFF0A4537);
  static const Color green900 = Color(0xFF073028);

  // ---- AI purple (Gemini) ----
  static const Color purple50 = Color(0xFFEEEDFE);
  static const Color purple100 = Color(0xFFDEDCFB);
  static const Color purple200 = Color(0xFFC2BEF5);
  static const Color purple300 = Color(0xFF9C95EC);
  static const Color purple400 = Color(0xFF7268D6);
  static const Color purple500 = Color(0xFF534AB7);
  static const Color purple600 = Color(0xFF3C3489);
  static const Color purple700 = Color(0xFF2E2769);

  // ---- Amber (user actions) ----
  static const Color amber50 = Color(0xFFFAEEDA);
  static const Color amber100 = Color(0xFFF6E0BD);
  static const Color amber200 = Color(0xFFEFC684);
  static const Color amber300 = Color(0xFFDDA23F);
  static const Color amber400 = Color(0xFFB8740F);
  static const Color amber500 = Color(0xFF99600C);
  static const Color amber600 = Color(0xFF854F0B);
  static const Color amber700 = Color(0xFF633806);

  // ---- Coral (loops / destructive) ----
  static const Color coral50 = Color(0xFFFAECE7);
  static const Color coral100 = Color(0xFFF6D9CE);
  static const Color coral200 = Color(0xFFEDB29E);
  static const Color coral300 = Color(0xFFDC7E5E);
  static const Color coral400 = Color(0xFFC25333);
  static const Color coral500 = Color(0xFFA8431F);
  static const Color coral600 = Color(0xFF993C1D);
  static const Color coral700 = Color(0xFF712B13);

  // ---- Blue (informational / selected) ----
  static const Color blue50 = Color(0xFFE6F1FB);
  static const Color blue100 = Color(0xFFCBE0F4);
  static const Color blue200 = Color(0xFF9BC2E8);
  static const Color blue300 = Color(0xFF5E97D4);
  static const Color blue400 = Color(0xFF2B72BE);
  static const Color blue500 = Color(0xFF185FA5);
  static const Color blue600 = Color(0xFF0C447C);
  static const Color blue700 = Color(0xFF093358);

  // ---- Warm neutrals (kitchen paper, slate) ----
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFFAFAF7);
  static const Color neutral100 = Color(0xFFF4F3EE);
  static const Color neutral200 = Color(0xFFE8E7E0);
  static const Color neutral300 = Color(0xFFD6D4CA);
  static const Color neutral400 = Color(0xFFA9A69A);
  static const Color neutral500 = Color(0xFF79766B);
  static const Color neutral600 = Color(0xFF57544B);
  static const Color neutral700 = Color(0xFF3B3933);
  static const Color neutral800 = Color(0xFF252420);
  static const Color neutral900 = Color(0xFF15140F);
}

/// Dark-adapted raw palette — mirrors the design-system dark tokens.
///
/// Reference in dark-specific one-off overrides. Prefer [AppColors] semantic
/// aliases for product code.
abstract final class AppDarkPalette {
  // ---- Brand green (dark-adapted) ----
  static const Color green50 = Color(0xFF11271F);
  static const Color green100 = Color(0xFF173628);
  static const Color green200 = Color(0xFF1F4434);
  static const Color green300 = Color(0xFF3FB389);
  static const Color green400 = Color(0xFF2BA17C);
  static const Color green500 = Color(0xFF2BA17C);
  static const Color green600 = Color(0xFF2FAE86);
  static const Color green700 = Color(0xFF34B98E);
  static const Color green800 = Color(0xFF0A4537);
  static const Color green900 = Color(0xFF073028);

  // ---- AI purple (dark-adapted) ----
  static const Color purple50 = Color(0xFF1B1840);
  static const Color purple100 = Color(0xFF241F4F);
  static const Color purple300 = Color(0xFF9C95EC);
  static const Color purple400 = Color(0xFF8B82E4);
  static const Color purple500 = Color(0xFF6E64CE);
  static const Color purple600 = Color(0xFF9A92E8);

  // ---- Amber (dark-adapted) ----
  static const Color amber50 = Color(0xFF2E1F08);
  static const Color amber100 = Color(0xFF3D2A0C);
  static const Color amber300 = Color(0xFFDDA23F);
  static const Color amber400 = Color(0xFFC8881C);
  static const Color amber600 = Color(0xFFE0A53A);
  static const Color amber700 = Color(0xFFE9B658);

  // ---- Coral (dark-adapted) ----
  static const Color coral50 = Color(0xFF331409);
  static const Color coral100 = Color(0xFF43200F);
  static const Color coral300 = Color(0xFFDC7E5E);
  static const Color coral600 = Color(0xFFE06A45);
  static const Color coral700 = Color(0xFFE8835F);

  // ---- Blue (dark-adapted) ----
  static const Color blue50 = Color(0xFF0E2238);
  static const Color blue100 = Color(0xFF14304D);
  static const Color blue300 = Color(0xFF5E97D4);
  static const Color blue500 = Color(0xFF5E97D4);
  static const Color blue600 = Color(0xFF7DB0E4);

  // ---- Warm neutral ramp (dark-tuned) ----
  static const Color neutral0 = Color(0xFF221D13); // raised card
  static const Color neutral50 = Color(0xFF181308); // canvas
  static const Color neutral100 = Color(0xFF251F14); // sunken / fills
  static const Color neutral200 = Color(0xFF322B1C);
  static const Color neutral300 = Color(0xFF423A27);
  static const Color neutral400 = Color(0xFF847C66); // faint text
  static const Color neutral500 = Color(0xFFA49C87); // muted text
  static const Color neutral600 = Color(0xFFC4BCA7);
  static const Color neutral700 = Color(0xFFDAD3C3); // body
  static const Color neutral800 = Color(0xFFE9E4D7);
  static const Color neutral900 = Color(0xFFF4F1E7); // strongest text

  // ---- Additional dark surfaces ----
  static const Color page = Color(0xFF0E0B06); // behind device / deepest
  static const Color sunken = Color(0xFF2B2417); // inset rows, tracks
}

/// Semantic color aliases — dark-first, reference these in product code.
///
/// The accent system mirrors the product flow:
///   • Green  — primary / fresh / results & data
///   • Purple — AI / Gemini intelligence
///   • Amber  — deliberate user actions (save, rate)
///   • Coral  — loops, destructive, warnings
///   • Blue   — informational / selected
abstract final class AppColors {
  // ---- Surfaces ----
  static const Color backgroundPrimary =
      AppDarkPalette.neutral0; // cards, sheets
  static const Color backgroundSecondary =
      AppDarkPalette.neutral50; // app canvas
  static const Color backgroundTertiary =
      AppDarkPalette.neutral100; // inset rows
  static const Color surfaceCard = AppDarkPalette.neutral0;
  static const Color surfaceCanvas = AppDarkPalette.neutral50;
  static const Color surfaceSunken = AppDarkPalette.neutral100;
  static const Color surfaceInverse = AppDarkPalette.neutral900;

  // ---- Text ----
  static const Color textPrimary = AppDarkPalette.neutral900;
  static const Color textSecondary = AppDarkPalette.neutral600;
  static const Color textTertiary = AppDarkPalette.neutral400;
  static const Color textInverse = AppDarkPalette.neutral50;
  static const Color textStrong = AppDarkPalette.neutral900;
  static const Color textBody = AppDarkPalette.neutral700;
  static const Color textMuted = AppDarkPalette.neutral500;
  static const Color textFaint = AppDarkPalette.neutral400;
  static const Color textOnAccent = AppDarkPalette.neutral900;

  // ---- Borders ----
  static const Color borderPrimary = AppDarkPalette.neutral300;
  static const Color borderSecondary = AppDarkPalette.neutral200;
  static const Color borderTertiary = AppDarkPalette.neutral100;
  static const Color borderStrong = AppDarkPalette.neutral300;
  static const Color borderDefault = AppDarkPalette.neutral200;
  static const Color borderSubtle = AppDarkPalette.neutral100;

  // ---- Primary (green) ----
  static const Color primary = Color(
    0xFF138062,
  ); // button bg — white text safe on dark
  static const Color primaryHover = AppPalette.green600;
  static const Color primaryActive = AppPalette.green700;
  static const Color primaryTint = AppDarkPalette.green50;
  static const Color primaryText =
      AppDarkPalette.green700; // bright green for text on dark
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ---- AI (purple) ----
  static const Color ai = Color(0xFF5F56C4);
  static const Color aiStrong = AppDarkPalette.purple600;
  static const Color aiTint = AppDarkPalette.purple50;
  static const Color aiText = AppDarkPalette.purple600;

  // ---- Action (amber) — save / rate ----
  static const Color action = AppDarkPalette.amber600; // bright amber on dark
  static const Color actionTint = AppDarkPalette.amber50;
  static const Color actionText = AppDarkPalette.amber700;

  // ---- Danger (coral) — destructive / loop ----
  static const Color danger = AppDarkPalette.coral600; // bright coral on dark
  static const Color dangerTint = AppDarkPalette.coral50;
  static const Color dangerText = AppDarkPalette.coral700;

  // ---- Info (blue) ----
  static const Color info = AppDarkPalette.blue500;
  static const Color infoTint = AppDarkPalette.blue50;
  static const Color infoText = AppDarkPalette.blue600;

  // ---- Success (green) ----
  static const Color success = AppDarkPalette.green600;
  static const Color successTint = AppDarkPalette.green50;

  // ---- Focus ring ----
  static const Color focusRing = AppPalette.green400;
}
