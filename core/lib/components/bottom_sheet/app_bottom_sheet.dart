import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_font_family.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Standard chrome for the app's modal bottom sheets: a safe-area inset,
/// horizontal padding, keyboard avoidance, a display-font [title] (optionally
/// centered, optionally with a close button) and a vertically-stacked body.
///
/// Pure UI — callers supply only the [title] and the body [children]. Open it
/// with [AppBottomSheet.show] to get the shared drag-handle treatment.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.title,
    required this.children,
    super.key,
    this.spacing = AppSpacing.s4,
    this.centerTitle = false,
    this.showCloseButton = false,
  });

  final String title;
  final List<Widget> children;
  final double spacing;
  final bool centerTitle;
  final bool showCloseButton;

  /// Opens [child] as a modal bottom sheet with the app's drag-handle styling.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: true,
      builder: (BuildContext context) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s0,
            AppSpacing.s5,
            AppSpacing.s6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: spacing,
            children: <Widget>[
              _Header(
                title: title,
                centerTitle: centerTitle,
                showCloseButton: showCloseButton,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

/// The sheet's display-font title, optionally centered and/or trailed by a
/// circular close button.
class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.centerTitle,
    required this.showCloseButton,
  });

  final String title;
  final bool centerTitle;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final Text titleText = Text(
      title,
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      style: context.textTheme.headlineMedium?.copyWith(
        fontFamily: AppFontFamily.display,
        fontWeight: AppFontWeight.bold,
      ),
    );

    if (!showCloseButton) return titleText;

    return Row(
      children: <Widget>[
        Expanded(child: titleText),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Close',
          style: IconButton.styleFrom(
            backgroundColor: AppColors.backgroundTertiary,
            foregroundColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
