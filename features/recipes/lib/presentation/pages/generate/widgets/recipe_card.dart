import 'package:core/components/tag/app_tag.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/recipe_entity.dart';
import '../../../recipe_mood.dart';
import '../../../widgets/recipe_photo.dart';

/// A tappable recipe result card: a photo placeholder topped with the mood
/// badge, then the title, blurb and cook-time / servings tags (PRD §4.3.3).
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    required this.recipe,
    required this.onTap,
    super.key,
  });

  final RecipeEntity recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final RecipeMood mood = RecipeMood.fromValue(recipe.mood);

    return Material(
      color: AppColors.surfaceCard,
      borderRadius: const BorderRadius.all(AppRadius.brLg),
      child: InkWell(
        borderRadius: const BorderRadius.all(AppRadius.brLg),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: const BorderRadius.all(AppRadius.brLg),
            border: Border.all(color: AppColors.borderDefault),
            boxShadow: AppShadows.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  RecipePhoto(mood: mood, height: 104),
                  Positioned(
                    top: AppSpacing.s3,
                    left: AppSpacing.s3,
                    child: AppTag(label: mood.label, icon: mood.icon, tone: mood.tone),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.title,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontFamily: AppFontFamily.display,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                    if (recipe.description != null) ...<Widget>[
                      const SizedBox(height: AppSpacing.s2),
                      Text(
                        recipe.description!,
                        style: context.textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.s3),
                    Wrap(
                      spacing: AppSpacing.s2,
                      runSpacing: AppSpacing.s2,
                      children: <Widget>[
                        if (recipe.cookTimeMinutes != null)
                          AppTag(label: '${recipe.cookTimeMinutes} min', icon: Icons.schedule_rounded),
                        if (recipe.servings != null)
                          AppTag(label: 'Serves ${recipe.servings}', icon: Icons.group_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
