import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/recipe_entity.dart';
import 'recipe_card.dart';

/// The three-recipe results screen: a scrollable list of [RecipeCard]s with a
/// pinned "Regenerate" action that re-runs generation with the same inputs
/// (PRD §4.3.3).
class RecipeResultsView extends StatelessWidget {
  const RecipeResultsView({
    required this.recipes,
    required this.onRegenerate,
    required this.onOpenRecipe,
    super.key,
  });

  final List<RecipeEntity> recipes;
  final VoidCallback onRegenerate;
  final ValueChanged<int> onOpenRecipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            padding: const .fromLTRB(
              AppSpacing.s5,
              AppSpacing.s3,
              AppSpacing.s5,
              AppSpacing.s5,
            ),
            itemCount: recipes.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.s4),
            itemBuilder: (BuildContext context, int index) {
              return RecipeCard(
                recipe: recipes[index],
                onTap: () => onOpenRecipe(index),
              );
            },
          ),
        ),
        _RegenerateBar(onRegenerate: onRegenerate),
      ],
    );
  }
}

/// The pinned secondary "Regenerate" action below the results.
class _RegenerateBar extends StatelessWidget {
  const _RegenerateBar({required this.onRegenerate});

  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .fromLTRB(
        AppSpacing.s5,
        AppSpacing.s3,
        AppSpacing.s5,
        AppSpacing.s4,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceCanvas,
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: OutlinedButton.icon(
        onPressed: onRegenerate,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Regenerate'),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppLayout.tapTarget),
        ),
      ),
    );
  }
}
