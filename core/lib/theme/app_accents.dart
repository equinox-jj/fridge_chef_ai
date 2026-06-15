import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic accent triple: a dark tint background, a legible foreground, and a
/// solid fill for badges (white text). Mirrors the design-system dark accent pairs.
///
/// Example — ingredient category icon tile:
///   Container(
///     decoration: BoxDecoration(color: AppAccents.green.tint),
///     child: Icon(Icons.eco, color: AppAccents.green.fg),
///   );
class Accent {
  const Accent({required this.tint, required this.fg, required this.solid});

  final Color tint; // soft dark background
  final Color fg; // legible foreground on [tint] or on canvas
  final Color solid; // saturated fill for badges (white text)
}

abstract final class AppAccents {
  static const Accent green = Accent(
    tint: AppColors.primaryTint,
    fg: AppColors.primaryText,
    solid: AppColors.primary,
  );
  static const Accent purple = Accent(
    tint: AppColors.aiTint,
    fg: AppColors.aiText,
    solid: AppColors.ai,
  );
  static const Accent amber = Accent(
    tint: AppColors.actionTint,
    fg: AppColors.actionText,
    solid: AppColors.action,
  );
  static const Accent coral = Accent(
    tint: AppColors.dangerTint,
    fg: AppColors.dangerText,
    solid: AppColors.danger,
  );
  static const Accent blue = Accent(
    tint: AppColors.infoTint,
    fg: AppColors.infoText,
    solid: AppColors.info,
  );
  static const Accent neutral = Accent(
    tint: AppColors.surfaceSunken,
    fg: AppColors.textBody,
    solid: AppColors.textMuted,
  );
}
