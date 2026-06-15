import 'package:core/components/icon_tile/app_icon_tile.dart';
import 'package:core/components/stepper/app_stepper.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/ingredient_entity.dart';
import '../ingredient_category.dart';

/// One editable ingredient row on the review screen: a category glyph, the
/// ingredient name, a quantity stepper, and a remove affordance.
class IngredientTile extends StatelessWidget {
  const IngredientTile({
    required this.ingredient,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    super.key,
  });

  final IngredientEntity ingredient;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final IngredientCategory category = IngredientCategory.fromValue(
      ingredient.category,
    );

    return Container(
      padding: const .fromLTRB(
        AppSpacing.s3,
        AppSpacing.s2,
        AppSpacing.s2,
        AppSpacing.s2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        border: .all(color: AppColors.borderDefault),
        borderRadius: const .all(AppRadius.brMd),
      ),
      child: Row(
        spacing: AppSpacing.s3,
        children: <Widget>[
          AppIconTile(
            icon: category.icon,
            size: 38,
            iconSize: AppTextSize.h3,
          ),
          Expanded(
            child: Text(
              _displayName,
              maxLines: 1,
              overflow: .ellipsis,
              style: context.textTheme.titleMedium,
            ),
          ),
          AppStepper(
            label: _quantityLabel,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close_rounded),
            iconSize: AppTextSize.h3,
            visualDensity: VisualDensity.compact,
            color: AppColors.textFaint,
            tooltip: 'Remove $_displayName',
          ),
        ],
      ),
    );
  }

  /// The AI returns lowercase names; show them title-cased for the user.
  String get _displayName {
    final String name = ingredient.name?.trim() ?? '';
    if (name.isEmpty) return 'Unknown';
    return name[0].toUpperCase() + name.substring(1);
  }

  /// "250 g" / "2 pcs" — falls back to the bare amount when no unit is known.
  String get _quantityLabel {
    final String qty = ingredient.quantity?.trim() ?? '';
    final String unit = ingredient.unit?.trim() ?? '';
    final String label = <String>[
      qty,
      unit,
    ].where((String s) => s.isNotEmpty).join(' ');
    return label.isEmpty ? '1' : label;
  }
}
