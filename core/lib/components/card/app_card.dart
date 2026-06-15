import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';

/// An elevated, rounded surface used to float content above the page.
///
/// Mirrors the design-system card: a white surface with an extra-large radius,
/// the `xl` shadow and comfortable padding. Each of [color], [borderRadius],
/// [boxShadow] and [padding] defaults to the design-system value but can be
/// overridden per use.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.padding = const .all(AppSpacing.s5),
    this.color = AppColors.surfaceCard,
    this.borderRadius = const .all(AppRadius.brXl),
    this.boxShadow = AppShadows.xl,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      padding: padding,
      child: child,
    );
  }
}
