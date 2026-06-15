import 'package:core/components/star_rating/app_star_rating.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/saved_recipe_entity.dart';
import '../../../recipe_mood.dart';
import '../../../widgets/recipe_photo.dart';

/// A single cookbook grid tile: the recipe's mood banner over its title, cook
/// time and the rating the user gave it (PRD §4.4).
///
/// Specific to the cookbook grid — it pairs a [SavedRecipeEntity] with the
/// two-up card layout from the design — so it lives with the page rather than
/// in `core/components`.
class CookbookCard extends StatelessWidget {
  const CookbookCard({
    required this.recipe,
    super.key,
    this.onTap,
  });

  final SavedRecipeEntity recipe;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceCard,
      borderRadius: const .all(AppRadius.brLg),
      child: InkWell(
        borderRadius: const .all(AppRadius.brLg),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: const .all(AppRadius.brLg),
            border: Border.all(color: AppColors.borderDefault),
            boxShadow: AppShadows.sm,
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: .vertical(top: AppRadius.brLg),
                ),
                child: RecipePhoto(
                  mood: RecipeMood.fromValue(recipe.mood),
                  height: 88,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s3),
                child: Column(
                  crossAxisAlignment: .start,
                  children: <Widget>[
                    Text(
                      recipe.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: AppFontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s2),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: <Widget>[
                        if (recipe.cookTimeMinutes != null)
                          Flexible(
                            child: Text(
                              '${recipe.cookTimeMinutes} min',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelMedium?.copyWith(
                                fontFamily: AppFontFamily.mono,
                                color: AppColors.textMuted,
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        const SizedBox(width: AppSpacing.s2),
                        AppStarRating(
                          value: recipe.rating,
                          size: AppStarRatingSize.sm,
                          readOnly: true,
                        ),
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
