import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// The app's shared "nothing here yet" placeholder: a faint [icon] above a
/// [title], an optional [message], and an optional call-to-action.
///
/// Used wherever a list or screen can be empty (recent scans, an empty
/// cookbook, the photo prompt, …) so empty states look and read the same
/// everywhere. The action only renders when both [actionLabel] and
/// [onAction] are supplied.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    super.key,
    this.message,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
    this.padding = const .symmetric(vertical: AppSpacing.s8),
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final bool hasAction = actionLabel != null && onAction != null;

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          Icon(
            icon,
            size: AppTextSize.display,
            color: AppColors.textFaint,
          ),
          const SizedBox(height: AppSpacing.s3),
          Text(
            title,
            textAlign: .center,
            style: context.textTheme.titleMedium,
          ),
          if (message != null) ...<Widget>[
            const SizedBox(height: AppSpacing.s2),
            Text(
              message!,
              textAlign: .center,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
          if (hasAction) ...<Widget>[
            const SizedBox(height: AppSpacing.s5),
            FilledButton.icon(
              onPressed: onAction,
              icon: Icon(actionIcon ?? Icons.add_rounded),
              label: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
