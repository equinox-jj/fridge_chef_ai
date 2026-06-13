import 'package:core/components/tag/app_tag.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/recipe_ingredient_entity.dart';

/// One ingredient line on the detail screen: the name on the left (a substitute
/// is tinted blue and carries a "substitute" badge — colour plus text, never
/// colour alone, per PRD §7.4) and the amount on the right in monospace.
class RecipeIngredientRow extends StatelessWidget {
  const RecipeIngredientRow({
    required this.ingredient,
    super.key,
  });

  final RecipeIngredientEntity ingredient;

  @override
  Widget build(BuildContext context) {
    final bool isSubstitute = ingredient.isSubstitute;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s2 + 2,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderSubtle,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _displayName,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isSubstitute ? AppColors.infoText : AppColors.textBody,
                fontWeight: isSubstitute ? AppFontWeight.medium : AppFontWeight.regular,
              ),
            ),
          ),
          if (isSubstitute) ...<Widget>[
            const SizedBox(width: AppSpacing.s2),
            const AppTag(
              label: 'substitute',
              tone: AppTagTone.blue,
            ),
          ],
          const Spacer(),
          if (_amount.isNotEmpty)
            Text(
              _amount,
              style: AppTypography.mono.copyWith(
                fontSize: AppTextSize.sm,
                color: AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }

  String get _displayName {
    final String name = ingredient.name?.trim() ?? '';
    if (name.isEmpty) return 'Ingredient';
    return name[0].toUpperCase() + name.substring(1);
  }

  /// "1 can" / "250 g" — empty when neither quantity nor unit is known.
  String get _amount {
    final String qty = ingredient.quantity?.trim() ?? '';
    final String unit = ingredient.unit?.trim() ?? '';
    return <String>[qty, unit].where((String s) => s.isNotEmpty).join(' ');
  }
}
