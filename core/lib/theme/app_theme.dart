import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_family.dart';
import 'app_layout.dart';
import 'app_radius.dart';
import 'app_typography.dart';

/// Dark-only application theme for FridgeScan AI.
///
/// Wire into `MaterialApp(theme: AppTheme.dark)`.
abstract final class AppTheme {
  static ThemeData get dark => _build(_darkScheme);

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryTint,
    onPrimaryContainer: AppColors.primaryText,
    secondary: AppColors.ai,
    onSecondary: AppColors.onPrimary,
    secondaryContainer: AppColors.aiTint,
    onSecondaryContainer: AppColors.aiText,
    tertiary: AppColors.action,
    onTertiary: AppColors.onPrimary,
    tertiaryContainer: AppColors.actionTint,
    onTertiaryContainer: AppColors.actionText,
    error: AppColors.danger,
    onError: AppColors.onPrimary,
    errorContainer: AppColors.dangerTint,
    onErrorContainer: AppColors.dangerText,
    surface: AppColors.surfaceCard,
    onSurface: AppColors.textStrong,
    surfaceContainerLowest: AppDarkPalette.page,
    surfaceContainerLow: AppColors.surfaceCanvas,
    surfaceContainer: AppColors.surfaceSunken,
    surfaceContainerHigh: AppDarkPalette.neutral200,
    surfaceContainerHighest: AppDarkPalette.neutral300,
    onSurfaceVariant: AppColors.textMuted,
    outline: AppColors.borderStrong,
    outlineVariant: AppColors.borderDefault,
    inverseSurface: AppColors.surfaceInverse,
    onInverseSurface: AppColors.textInverse,
    inversePrimary: AppDarkPalette.green600,
    surfaceTint: AppColors.primary,
    shadow: AppDarkPalette.page,
    scrim: AppDarkPalette.page,
  );

  static ThemeData _build(ColorScheme scheme) {
    final TextTheme textTheme = AppTypography.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppFontFamily.body,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.surfaceCanvas,
      splashFactory: InkSparkle.splashFactory,
      focusColor: AppColors.focusRing,
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: AppBorderWidth.hairline,
        space: AppBorderWidth.hairline,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceCanvas,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(AppRadius.brMd),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        border: OutlineInputBorder(
          borderRadius: .all(AppRadius.brMd),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .all(AppRadius.brMd),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: .all(AppRadius.brMd),
          borderSide: BorderSide(
            color: scheme.primary,
            width: AppBorderWidth.thick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: .all(AppRadius.brMd),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: .all(AppRadius.brMd),
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
          shape: RoundedRectangleBorder(
            borderRadius: .all(AppRadius.brFull),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: .all(AppRadius.brLg),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainer,
        side: BorderSide(color: scheme.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: .all(AppRadius.brFull),
        ),
        labelStyle: textTheme.labelLarge,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: scheme.outlineVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: .vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: .all(AppRadius.brLg),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: .all(AppRadius.brSm),
        ),
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: AppLayout.navHeight,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
      ),
    );
  }

  static ButtonStyle _buttonStyle(TextTheme textTheme) {
    return FilledButton.styleFrom(
      minimumSize: const Size(0, AppLayout.tapTarget),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: textTheme.labelLarge,
      shape: RoundedRectangleBorder(
        borderRadius: .all(AppRadius.brFull),
      ),
    );
  }
}
