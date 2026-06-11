import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// The home header: a time-of-day eyebrow ("GOOD EVENING, MARA") above the
/// "What's in the fridge?" headline.
///
/// Pass the signed-in user's [name] to personalise the greeting; when it is
/// null or empty the name is simply dropped.
class HomeGreeting extends StatelessWidget {
  const HomeGreeting({
    super.key,
    this.name,
  });

  final String? name;

  /// Greeting word based on the current hour.
  static String _greetingFor(DateTime now) {
    final int hour = now.hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final String greeting = _greetingFor(DateTime.now());
    final String eyebrow = (name == null || name!.isEmpty) ? greeting : '$greeting, $name';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s2,
      children: <Widget>[
        Text(
          eyebrow.toUpperCase(),
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textMuted,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Text(
          "What's in the fridge?",
          style: context.textTheme.displayMedium,
        ),
      ],
    );
  }
}
