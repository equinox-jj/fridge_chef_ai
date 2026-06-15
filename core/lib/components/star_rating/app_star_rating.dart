import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

/// Glyph size preset for an [AppStarRating].
enum AppStarRatingSize { sm, md, lg }

/// A 1–5 amber star control.
///
/// Interactive by default; pass [readOnly] to display a fixed rating. [onChanged]
/// fires with the tapped star's value (1-based).
class AppStarRating extends StatelessWidget {
  const AppStarRating({
    super.key,
    this.value = 0,
    this.onChanged,
    this.max = 5,
    this.size = AppStarRatingSize.md,
    this.readOnly = false,
  });

  final int value;
  final ValueChanged<int>? onChanged;
  final int max;
  final AppStarRatingSize size;
  final bool readOnly;

  double get _iconSize {
    switch (size) {
      case AppStarRatingSize.sm:
        return AppTextSize.lg - 1; // 16
      case AppStarRatingSize.md:
        return AppTextSize.h2; // 22
      case AppStarRatingSize.lg:
        return AppTextSize.display - 4; // 30
    }
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = _iconSize;

    return Semantics(
      label: '$value of $max stars',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(max, (int index) {
          final int starValue = index + 1;
          final bool on = starValue <= value;
          final Widget star = Icon(
            on ? Icons.star_rounded : Icons.star_outline_rounded,
            size: iconSize,
            color: on ? AppDarkPalette.amber400 : AppDarkPalette.neutral300,
          );

          if (readOnly || onChanged == null) return star;

          return GestureDetector(
            onTap: () => onChanged?.call(starValue),
            behavior: HitTestBehavior.opaque,
            child: star,
          );
        }),
      ),
    );
  }
}
