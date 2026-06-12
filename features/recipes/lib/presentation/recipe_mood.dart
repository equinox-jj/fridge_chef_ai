import 'package:core/components/tag/app_tag.dart';
import 'package:flutter/material.dart';

/// The five moods a user can tune recipe generation to (PRD §4.3.1).
///
/// The [value] is the data-layer token injected into the Gemini prompt; [label]
/// and [icon] are presentation, and [tone] colours the mood badge on recipe
/// cards. Lives in the presentation layer because only the UI groups and
/// decorates by mood — generation itself just needs the [value] string.
enum RecipeMood {
  quick('quick', 'Quick', Icons.bolt_rounded, AppTagTone.blue),
  comfort('comfort', 'Comfort', Icons.ramen_dining_rounded, AppTagTone.amber),
  healthy('healthy', 'Healthy', Icons.spa_rounded, AppTagTone.green),
  adventurous('adventurous', 'Adventurous', Icons.explore_rounded, AppTagTone.purple),
  simple('simple', 'Simple', Icons.radio_button_checked_rounded, AppTagTone.neutral);

  const RecipeMood(this.value, this.label, this.icon, this.tone);

  /// Prompt token / persisted value for the mood.
  final String value;

  /// Human-readable chip label.
  final String label;

  /// Glyph shown on the mood chip and badge.
  final IconData icon;

  /// Accent used for the mood badge on a recipe card.
  final AppTagTone tone;

  /// Resolves a raw [value] back to its mood, falling back to [simple] for
  /// anything unrecognised so a stray value never breaks the UI.
  static RecipeMood fromValue(String? value) {
    return RecipeMood.values.firstWhere(
      (RecipeMood m) => m.value == value,
      orElse: () => RecipeMood.simple,
    );
  }
}
