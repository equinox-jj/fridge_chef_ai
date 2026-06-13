import 'package:flutter/material.dart';

import '../../constants/dietary/dietary_preference.dart';
import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// A single-select chip grid over every [DietaryPreference].
///
/// Pure, controlled UI: it renders [selected] and reports taps through
/// [onSelected] — it holds no state and persists nothing, so the caller owns
/// the choice. Shared in `core` because the same control appears in more than
/// one place (the profile dietary-preference sheet and the onboarding dietary
/// setup), keeping the chip vocabulary identical everywhere it is used.
class DietaryPreferenceChips extends StatelessWidget {
  const DietaryPreferenceChips({
    required this.selected,
    required this.onSelected,
    this.alignment = WrapAlignment.start,
    super.key,
  });

  /// The currently chosen preference, rendered as the active chip.
  final DietaryPreference selected;

  /// Called with the tapped preference. The caller updates [selected].
  final ValueChanged<DietaryPreference> onSelected;

  /// How the chips are distributed when they wrap onto multiple lines.
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: AppSpacing.s2,
      runSpacing: AppSpacing.s2,
      children: DietaryPreference.values.map((DietaryPreference diet) {
        final bool isSelected = diet == selected;
        return ChoiceChip(
          selected: isSelected,
          onSelected: (_) => onSelected(diet),
          label: Text(diet.label),
          showCheckmark: false,
          selectedColor: AppColors.primary,
          labelStyle: context.textTheme.labelLarge?.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.textBody,
            fontWeight: AppFontWeight.semiBold,
          ),
        );
      }).toList(),
    );
  }
}
