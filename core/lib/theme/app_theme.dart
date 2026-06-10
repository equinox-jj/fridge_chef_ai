import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_family.dart';
import 'app_layout.dart';
import 'app_radius.dart';
import 'app_typography.dart';

/// Base application theme for FridgeScan AI.
///
/// Translates the design tokens (colors, typography, radius, layout) into a
/// Material 3 [ThemeData]. The light theme maps the semantic tokens directly;
/// the dark theme is derived from the brand seed since the tokens are
/// light-first. Wire into `MaterialApp(theme: AppTheme.light, darkTheme: ...)`.
abstract final class AppTheme {
  static ThemeData get light => _build(_lightScheme);

  static ThemeData get dark => _build(_darkScheme);

  /// Light color scheme mapped straight from the semantic tokens.
  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    // Primary — brand green.
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryTint,
    onPrimaryContainer: AppColors.primaryText,
    // Secondary — AI purple.
    secondary: AppColors.ai,
    onSecondary: AppColors.textOnAccent,
    secondaryContainer: AppColors.aiTint,
    onSecondaryContainer: AppColors.aiText,
    // Tertiary — action amber.
    tertiary: AppColors.action,
    onTertiary: AppColors.textOnAccent,
    tertiaryContainer: AppColors.actionTint,
    onTertiaryContainer: AppColors.actionText,
    // Error — coral.
    error: AppColors.danger,
    onError: AppColors.textOnAccent,
    errorContainer: AppColors.dangerTint,
    onErrorContainer: AppColors.dangerText,
    // Surfaces / neutrals.
    surface: AppColors.surfaceCard,
    onSurface: AppColors.textPrimary,
    surfaceContainerLowest: AppPalette.neutral0,
    surfaceContainerLow: AppPalette.neutral50,
    surfaceContainer: AppPalette.neutral100,
    surfaceContainerHigh: AppPalette.neutral200,
    surfaceContainerHighest: AppPalette.neutral300,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.borderStrong,
    outlineVariant: AppColors.borderDefault,
    inverseSurface: AppColors.surfaceInverse,
    onInverseSurface: AppColors.textInverse,
    inversePrimary: AppPalette.green300,
    surfaceTint: AppColors.primary,
    shadow: AppPalette.neutral900,
    scrim: AppPalette.neutral900,
  );

  /// Dark scheme derived from the brand seed (no dark tokens are defined).
  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    primary: AppPalette.green300,
    secondary: AppPalette.purple300,
    tertiary: AppPalette.amber300,
    error: AppPalette.coral300,
  );

  static ThemeData _build(ColorScheme scheme) {
    final bool isLight = scheme.brightness == Brightness.light;
    final TextTheme textTheme = AppTypography.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppFontFamily.body,
      textTheme: textTheme,
      scaffoldBackgroundColor: isLight
          ? AppColors.surfaceCanvas
          : scheme.surface,
      splashFactory: InkSparkle.splashFactory,
      focusColor: AppColors.focusRing,
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: AppBorderWidth.hairline,
        space: AppBorderWidth.hairline,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isLight ? AppColors.surfaceCanvas : scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: AppLayout.headerHeight,
        titleTextStyle: textTheme.headlineSmall,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.brMd),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(
            color: scheme.primary,
            width: AppBorderWidth.thick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.brMd,
          borderSide: BorderSide(
            color: scheme.error,
            width: AppBorderWidth.thick,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(style: _buttonStyle(textTheme)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _buttonStyle(textTheme).copyWith(
          backgroundColor: WidgetStatePropertyAll<Color>(scheme.primary),
          foregroundColor: WidgetStatePropertyAll<Color>(scheme.onPrimary),
          elevation: const WidgetStatePropertyAll<double>(0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _buttonStyle(textTheme).copyWith(
          foregroundColor: WidgetStatePropertyAll<Color>(scheme.primary),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(color: scheme.outline, width: AppBorderWidth.hairline),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.brFull),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.brLg),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: isLight ? AppColors.surfaceSunken : scheme.surface,
        side: BorderSide(color: scheme.outlineVariant),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.brFull),
        labelStyle: textTheme.labelLarge,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
      ),
      dialogTheme: const DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.brLg),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.brSm),
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: AppLayout.navHeight,
        backgroundColor: scheme.surface,
        indicatorColor: isLight ? AppColors.primaryTint : scheme.primaryContainer,
        labelTextStyle: WidgetStatePropertyAll<TextStyle?>(textTheme.labelMedium),
      ),
    );
  }

  static ButtonStyle _buttonStyle(TextTheme textTheme) {
    return FilledButton.styleFrom(
      minimumSize: const Size(0, AppLayout.tapTarget),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: textTheme.labelLarge,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.brFull),
    );
  }
}
