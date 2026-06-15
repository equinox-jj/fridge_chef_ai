import 'package:core/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../ingredient_category.dart';

/// The data a user enters when manually adding an ingredient the AI missed.
typedef NewIngredient = ({
  String name,
  String quantity,
  String unit,
  String category,
});

/// Bottom sheet for adding an ingredient by hand (PRD OQ-1): a name, an
/// optional quantity + unit, and one of the eight ingredient categories.
///
/// [openSheet] resolves with the entered [NewIngredient], or `null` if the
/// sheet is dismissed without confirming.
class AddIngredientSheet extends StatefulWidget {
  const AddIngredientSheet({super.key});

  static Future<NewIngredient?> openSheet(BuildContext context) {
    return AppBottomSheet.show<NewIngredient>(
      context,
      child: const AddIngredientSheet(),
    );
  }

  @override
  State<AddIngredientSheet> createState() => _AddIngredientSheetState();
}

class _AddIngredientSheetState extends State<AddIngredientSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  /// Selected category and live name-emptiness, kept as notifiers so only the
  /// category chips and the confirm button rebuild — the text fields don't.
  final ValueNotifier<IngredientCategory> _category =
      ValueNotifier<IngredientCategory>(
        IngredientCategory.produce,
      );
  final ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_onNameChanged)
      ..dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _category.dispose();
    _canSubmit.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    _canSubmit.value = _nameController.text.trim().isNotEmpty;
  }

  void _submit() {
    if (!_canSubmit.value) return;
    final NewIngredient result = (
      name: _nameController.text.trim(),
      quantity: _quantityController.text.trim(),
      unit: _unitController.text.trim(),
      category: _category.value.value,
    );
    context.pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Add an ingredient',
      children: <Widget>[
        TextField(
          controller: _nameController,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'e.g. mushrooms',
            prefixIcon: Icon(Icons.edit_outlined),
          ),
        ),
        Row(
          spacing: AppSpacing.s3,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextField(
                controller: _quantityController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'e.g. 200',
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _unitController,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Unit',
                  hintText: 'g',
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<IngredientCategory>(
          valueListenable: _category,
          builder: (_, IngredientCategory category, _) => _CategoryPicker(
            selected: category,
            onSelected: (IngredientCategory selected) =>
                _category.value = selected,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _canSubmit,
          builder: (_, bool canSubmit, _) => FilledButton.icon(
            onPressed: canSubmit ? _submit : null,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add ingredient'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(AppLayout.tapTarget),
            ),
          ),
        ),
      ],
    );
  }
}

/// The "Category" label above a wrap of selectable category chips.
class _CategoryPicker extends StatelessWidget {
  const _CategoryPicker({
    required this.selected,
    required this.onSelected,
  });

  final IngredientCategory selected;
  final ValueChanged<IngredientCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.s2,
      children: <Widget>[
        Text(
          'CATEGORY',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.textMuted,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Wrap(
          spacing: AppSpacing.s2,
          runSpacing: AppSpacing.s2,
          children: IngredientCategory.values.map((
            IngredientCategory category,
          ) {
            return ChoiceChip(
              selected: category == selected,
              onSelected: (_) => onSelected(category),
              avatar: Icon(
                category.icon,
                size: AppTextSize.base,
                color: category == selected
                    ? AppColors.onPrimary
                    : AppColors.textMuted,
              ),
              label: Text(category.label),
              showCheckmark: false,
              selectedColor: AppColors.primary,
              labelStyle: context.textTheme.labelLarge?.copyWith(
                color: category == selected
                    ? AppColors.onPrimary
                    : AppColors.textBody,
                fontWeight: AppFontWeight.semiBold,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
