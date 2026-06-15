import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:core/constants/dietary/dietary_preference.dart';

import '../../../recipe_mood.dart';
import '../bloc/recipe_generation_bloc.dart';

/// The mood selection screen (PRD §4.3.1): a chip grid of the five moods, a
/// banner showing the dietary preference pulled from the profile, and a pinned
/// "Generate recipes" action that stays disabled until a mood is chosen.
class MoodPickerView extends StatelessWidget {
  const MoodPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s5,
              AppSpacing.s3,
              AppSpacing.s5,
              AppSpacing.s5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'What are you in the mood for?',
                  style: context.textTheme.displaySmall?.copyWith(
                    fontFamily: AppFontFamily.display,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.s1),
                Text(
                  "We'll tune the 3 recipes to match.",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.s5),
                const _MoodChips(),
                const SizedBox(height: AppSpacing.s5),
                const _DietBanner(),
              ],
            ),
          ),
        ),
        const _GenerateBar(),
      ],
    );
  }
}

/// The wrap of selectable mood chips, bound to the bloc's selected mood.
class _MoodChips extends StatelessWidget {
  const _MoodChips();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      RecipeGenerationBloc,
      RecipeGenerationState,
      RecipeMood?
    >(
      selector: (RecipeGenerationState state) => state.mood,
      builder: (BuildContext context, RecipeMood? selected) {
        return Wrap(
          spacing: AppSpacing.s2,
          runSpacing: AppSpacing.s2,
          children: RecipeMood.values.map((RecipeMood mood) {
            final bool isSelected = mood == selected;
            return ChoiceChip(
              selected: isSelected,
              onSelected: (_) => context.read<RecipeGenerationBloc>().add(
                RecipeGenerationEvent.moodSelected(mood),
              ),
              avatar: Icon(
                mood.icon,
                size: AppTextSize.base,
                color: isSelected ? AppColors.onPrimary : AppColors.textMuted,
              ),
              label: Text(mood.label),
              showCheckmark: false,
              selectedColor: AppColors.primary,
              labelStyle: context.textTheme.labelLarge?.copyWith(
                color: isSelected ? AppColors.onPrimary : AppColors.textBody,
                fontWeight: AppFontWeight.semiBold,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/// The purple banner noting which dietary preference will be applied.
class _DietBanner extends StatelessWidget {
  const _DietBanner();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      RecipeGenerationBloc,
      RecipeGenerationState,
      DietaryPreference
    >(
      selector: (RecipeGenerationState state) => state.dietaryPreference,
      builder: (BuildContext context, DietaryPreference diet) {
        final bool hasDiet = diet != DietaryPreference.none;
        return Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            color: AppColors.aiTint,
            borderRadius: const BorderRadius.all(AppRadius.brMd),
          ),
          child: Row(
            spacing: AppSpacing.s3,
            children: <Widget>[
              const Icon(
                Icons.eco_rounded,
                size: AppTextSize.h3,
                color: AppColors.ai,
              ),
              Expanded(
                child: Text.rich(
                  hasDiet
                      ? TextSpan(
                          text: 'Using your ',
                          children: <TextSpan>[
                            TextSpan(
                              text: diet.label,
                              style: const TextStyle(
                                fontWeight: AppFontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' preference from your profile.',
                            ),
                          ],
                        )
                      : const TextSpan(
                          text:
                              'No dietary preference set — recipes can use anything.',
                        ),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.aiText,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// The pinned "Generate recipes" action — purple (an AI moment), disabled until
/// a mood is selected.
class _GenerateBar extends StatelessWidget {
  const _GenerateBar();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RecipeGenerationBloc, RecipeGenerationState, bool>(
      selector: (RecipeGenerationState state) => state.mood != null,
      builder: (BuildContext context, bool canGenerate) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s3,
            AppSpacing.s5,
            AppSpacing.s4,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surfaceCanvas,
            border: Border(top: BorderSide(color: AppColors.borderSubtle)),
          ),
          child: FilledButton.icon(
            onPressed: canGenerate
                ? () => context.read<RecipeGenerationBloc>().add(
                    const RecipeGenerationEvent.generateRequested(),
                  )
                : null,
            icon: const Icon(Icons.auto_awesome_rounded),
            label: const Text('Generate recipes'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.ai,
              foregroundColor: AppColors.textOnAccent,
              minimumSize: const Size.fromHeight(AppLayout.tapTarget),
            ),
          ),
        );
      },
    );
  }
}
