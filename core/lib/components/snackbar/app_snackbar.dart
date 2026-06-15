import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_font_family.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Semantic kind of an [AppSnackbar], driving its icon and accent color.
enum AppSnackbarType { success, error, warning, info }

/// A reusable, themed snackbar with a leading accent icon.
///
/// Floating, rounded, with a colored icon chip and an optional bold [title].
/// Call the helpers from anywhere with a [BuildContext]:
///
/// ```dart
/// AppSnackbar.success(context, 'Recipe saved');
/// AppSnackbar.error(context, 'Something went wrong');
/// ```
abstract final class AppSnackbar {
  static void success(
    BuildContext context,
    String message, {
    String? title,
  }) => _show(
    context,
    AppSnackbarType.success,
    message,
    title,
  );

  static void error(
    BuildContext context,
    String message, {
    String? title,
  }) => _show(
    context,
    AppSnackbarType.error,
    message,
    title,
  );

  static void warning(
    BuildContext context,
    String message, {
    String? title,
  }) => _show(
    context,
    AppSnackbarType.warning,
    message,
    title,
  );

  static void info(
    BuildContext context,
    String message, {
    String? title,
  }) => _show(
    context,
    AppSnackbarType.info,
    message,
    title,
  );

  static void _show(
    BuildContext context,
    AppSnackbarType type,
    String message,
    String? title,
  ) {
    context.scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(build(type, message, title: title));
  }

  /// Builds the [SnackBar] for [type] without showing it — handy for tests or
  /// custom presentation.
  static SnackBar build(
    AppSnackbarType type,
    String message, {
    String? title,
  }) {
    final _SnackbarStyle style = _styleFor(type);

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.surfaceCard,
      elevation: 0,
      margin: const EdgeInsets.all(AppSpacing.s4),
      padding: const EdgeInsets.all(AppSpacing.s3),
      duration: const Duration(seconds: 4),
      shape: RoundedRectangleBorder(
        borderRadius: const .all(AppRadius.brLg),
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
      content: Row(
        spacing: AppSpacing.s3,
        children: <Widget>[
          Container(
            width: AppSpacing.s8, // 40
            height: AppSpacing.s8,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: style.tint,
              borderRadius: const .all(AppRadius.brMd),
            ),
            child: Icon(
              style.icon,
              color: style.accent,
              size: AppTextSize.h2,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: .start,
              children: <Widget>[
                if (title != null)
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppFontFamily.body,
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppTextSize.base,
                      color: AppColors.textPrimary,
                    ),
                  ),
                Text(
                  message,
                  style: const TextStyle(
                    fontFamily: AppFontFamily.body,
                    fontWeight: AppFontWeight.regular,
                    fontSize: AppTextSize.sm,
                    height: AppLineHeight.normal,
                    color: AppColors.textBody,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static _SnackbarStyle _styleFor(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.success:
        return const _SnackbarStyle(
          Icons.check_circle_rounded,
          AppColors.success,
          AppColors.successTint,
        );
      case AppSnackbarType.error:
        return const _SnackbarStyle(
          Icons.error_rounded,
          AppColors.danger,
          AppColors.dangerTint,
        );
      case AppSnackbarType.warning:
        return const _SnackbarStyle(
          Icons.warning_rounded,
          AppColors.action,
          AppColors.actionTint,
        );
      case AppSnackbarType.info:
        return const _SnackbarStyle(
          Icons.info_rounded,
          AppColors.info,
          AppColors.infoTint,
        );
    }
  }
}

class _SnackbarStyle {
  const _SnackbarStyle(
    this.icon,
    this.accent,
    this.tint,
  );

  final IconData icon;
  final Color accent;
  final Color tint;
}
