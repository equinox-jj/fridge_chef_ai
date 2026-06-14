import 'package:core/components/tag/app_tag.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/entities/recipe_ingredient_entity.dart';
import '../../../../domain/entities/recipe_step_entity.dart';
import '../../../recipe_mood.dart';
import '../../../widgets/recipe_photo.dart';
import 'recipe_ingredient_row.dart';
import 'recipe_step_tile.dart';

/// The scrolling recipe content — photo header, mood/time/servings badges, the
/// ingredient list and the numbered steps.
///
/// Shared by the generation-flow detail page (which saves a freshly generated
/// recipe) and the cookbook detail page (which reads a saved one), so both
/// render a recipe identically; only the surrounding chrome (save bar vs. none)
/// differs.
class RecipeDetailContent extends StatelessWidget {
  const RecipeDetailContent({required this.recipe, super.key});

  final RecipeEntity recipe;

  @override
  Widget build(BuildContext context) {
    final RecipeMood mood = RecipeMood.fromValue(recipe.mood);

    return ListView(
      // Leave room for the floating app bar at the top and the save bar below.
      padding: const EdgeInsets.only(bottom: AppSpacing.s6),
      children: <Widget>[
        RecipePhoto(mood: mood, height: 220),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s4,
            AppSpacing.s5,
            AppSpacing.s0,
          ),
          child: Wrap(
            spacing: AppSpacing.s2,
            runSpacing: AppSpacing.s2,
            children: <Widget>[
              AppTag(
                label: mood.label,
                icon: mood.icon,
                tone: mood.tone,
              ),
              if (recipe.cookTimeMinutes != null)
                AppTag(label: '${recipe.cookTimeMinutes} min', icon: Icons.schedule_rounded),
              if (recipe.servings != null)
                AppTag(
                  label: 'Serves ${recipe.servings}',
                  icon: Icons.group_rounded,
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s3,
            AppSpacing.s5,
            AppSpacing.s0,
          ),
          child: Text(
            recipe.title,
            style: context.textTheme.displayMedium?.copyWith(
              fontFamily: AppFontFamily.display,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        ),
        if (recipe.description != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s5,
              AppSpacing.s2,
              AppSpacing.s5,
              AppSpacing.s0,
            ),
            child: Text(
              recipe.description!,
              style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
          ),
        if (recipe.ingredients.isNotEmpty) ...<Widget>[
          const _SectionTitle('Ingredients'),
          for (final RecipeIngredientEntity ingredient in recipe.ingredients)
            RecipeIngredientRow(ingredient: ingredient),
        ],
        if (recipe.steps.isNotEmpty) ...<Widget>[
          const _SectionTitle('Steps'),
          for (final RecipeStepEntity step in recipe.steps) RecipeStepTile(step: step),
        ],
      ],
    );
  }
}

/// A display-font section heading ("Ingredients" / "Steps").
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.s5, AppSpacing.s6, AppSpacing.s5, AppSpacing.s2),
      child: Text(
        title,
        style: context.textTheme.headlineSmall?.copyWith(
          fontFamily: AppFontFamily.display,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}

/// A back button with a solid circular backing so it stays legible over the
/// photo header. Shared by both recipe detail screens.
class RecipeDetailBackButton extends StatelessWidget {
  const RecipeDetailBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.maybePop(),
      icon: const Icon(Icons.arrow_back_rounded),
      tooltip: 'Back',
      style: IconButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: AppColors.surfaceCard,
        foregroundColor: AppColors.textPrimary,
      ),
    );
  }
}
