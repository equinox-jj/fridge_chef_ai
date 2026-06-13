import 'package:core/components/button/app_submit_button.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

/// Bottom sheet for choosing the dietary preference applied to every generated
/// recipe (design 4.2): a single-select chip grid over [DietaryPreference],
/// pre-filled with the user's [current] choice.
///
/// [openSheet] resolves with the chosen preference, or `null` if dismissed
/// without saving. Pure UI — the caller persists the result.
class DietaryPreferenceSheet extends StatefulWidget {
  const DietaryPreferenceSheet({required this.current, super.key});

  final DietaryPreference current;

  static Future<DietaryPreference?> openSheet(
    BuildContext context, {
    required DietaryPreference current,
  }) {
    return showModalBottomSheet<DietaryPreference>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => DietaryPreferenceSheet(current: current),
    );
  }

  @override
  State<DietaryPreferenceSheet> createState() => _DietaryPreferenceSheetState();
}

class _DietaryPreferenceSheetState extends State<DietaryPreferenceSheet> {
  late DietaryPreference _selected = widget.current;

  void _save() => context.pop(_selected);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          spacing: AppSpacing.s4,
          children: <Widget>[
            Text(
              'Dietary preference',
              style: context.textTheme.headlineMedium?.copyWith(
                fontFamily: AppFontFamily.display,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            Text(
              'Applied to every recipe Gemini writes for you.',
              style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            Wrap(
              spacing: AppSpacing.s2,
              runSpacing: AppSpacing.s2,
              children: DietaryPreference.values.map((DietaryPreference diet) {
                final bool isSelected = diet == _selected;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selected = diet),
                  label: Text(diet.label),
                  showCheckmark: false,
                  selectedColor: AppColors.primary,
                  labelStyle: context.textTheme.labelLarge?.copyWith(
                    color: isSelected ? AppColors.onPrimary : AppColors.textBody,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                );
              }).toList(),
            ),
            AppSubmitButton(
              label: 'Save',
              icon: Icons.check_rounded,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
