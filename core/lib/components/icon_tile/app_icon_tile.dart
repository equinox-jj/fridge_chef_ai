import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

/// A rounded square that frames a single [icon].
///
/// Used as the leading glyph for cards and list rows throughout the app (the
/// scan CTA, recent-scan rows, …). Colors, [size] and corner [borderRadius]
/// default to the design-system tint/primary pairing but can be overridden, and
/// an optional [boxShadow] gives the tile a colored glow when it needs emphasis.
class AppIconTile extends StatelessWidget {
  const AppIconTile({
    required this.icon,
    super.key,
    this.size = 48,
    this.iconSize,
    this.backgroundColor = AppColors.primaryTint,
    this.foregroundColor = AppColors.primary,
    this.borderRadius = const .all(AppRadius.brSm),
    this.boxShadow,
  });

  final IconData icon;
  final double size;

  /// Glyph size. Defaults to roughly half the tile so it stays balanced.
  final double? iconSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: .center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        size: iconSize ?? size * 0.5,
        color: foregroundColor,
      ),
    );
  }
}
