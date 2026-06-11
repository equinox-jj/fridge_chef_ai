import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_typography.dart';

/// A section title with an optional trailing text action (e.g. "See all").
///
/// The action only renders when both [actionLabel] and [onActionPressed] are
/// supplied, so the same header works for sections that do and don't link out.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    super.key,
    this.actionLabel,
    this.onActionPressed,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final bool hasAction = actionLabel != null && onActionPressed != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            title,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ),
        if (hasAction)
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: context.textTheme.labelLarge?.copyWith(
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            child: Text(actionLabel!),
          ),
      ],
    );
  }
}
