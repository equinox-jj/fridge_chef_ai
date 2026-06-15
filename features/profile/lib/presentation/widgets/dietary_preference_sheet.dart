import 'package:core/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/dietary_chips/dietary_preference_chips.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
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
    return AppBottomSheet.show<DietaryPreference>(
      context,
      child: DietaryPreferenceSheet(current: current),
    );
  }

  @override
  State<DietaryPreferenceSheet> createState() => _DietaryPreferenceSheetState();
}

class _DietaryPreferenceSheetState extends State<DietaryPreferenceSheet> {
  /// The chosen preference; a notifier so picking a chip rebuilds only the
  /// chip grid, not the sheet's headers and Save button.
  late final ValueNotifier<DietaryPreference> _selected =
      ValueNotifier<DietaryPreference>(
        widget.current,
      );

  @override
  void dispose() {
    _selected.dispose();
    super.dispose();
  }

  void _save() => context.pop(_selected.value);

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Dietary preference',
      children: <Widget>[
        Text(
          'Applied to every recipe Gemini writes for you.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        ValueListenableBuilder<DietaryPreference>(
          valueListenable: _selected,
          builder: (_, DietaryPreference selected, _) => DietaryPreferenceChips(
            selected: selected,
            onSelected: (DietaryPreference diet) => _selected.value = diet,
          ),
        ),
        AppSubmitButton(
          label: 'Save',
          icon: Icons.check_rounded,
          onPressed: _save,
        ),
      ],
    );
  }
}
