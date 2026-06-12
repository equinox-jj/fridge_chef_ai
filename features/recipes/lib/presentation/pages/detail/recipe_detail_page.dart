import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/components/tag/app_tag.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/recipe_entity.dart';
import '../../../domain/entities/recipe_ingredient_entity.dart';
import '../../../domain/entities/recipe_step_entity.dart';
import '../../recipe_mood.dart';
import '../../widgets/recipe_photo.dart';
import '../../widgets/save_rate_sheet.dart';
import 'cubit/save_recipe_cubit.dart';
import 'widgets/recipe_ingredient_row.dart';
import 'widgets/recipe_step_tile.dart';

/// Full recipe view: photo header, mood/time/servings badges, the ingredient
/// list (substitutes flagged), the numbered steps with timers, and a sticky
/// "Save to cookbook" action (PRD §4.3.4).
class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({required this.recipe, super.key});

  final RecipeEntity recipe;

  Future<void> _onSave(BuildContext context) async {
    final SaveRecipeCubit cubit = context.read<SaveRecipeCubit>();
    final RecipeRating? rating = await SaveRateSheet.openSheet(context);
    if (rating == null) return;
    await cubit.save(
      rating: rating.stars,
      note: rating.note.isEmpty ? null : rating.note,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Padding(
          padding: EdgeInsets.only(left: AppSpacing.s2),
          child: _SolidBackButton(),
        ),
      ),
      body: BlocListener<SaveRecipeCubit, SaveRecipeState>(
        listenWhen: (SaveRecipeState p, SaveRecipeState c) => p.status != c.status,
        listener: _onSaveStateChanged,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: _RecipeBody(recipe: recipe)),
            _SaveBar(onSave: () => _onSave(context)),
          ],
        ),
      ),
    );
  }

  void _onSaveStateChanged(BuildContext context, SaveRecipeState state) {
    switch (state.status) {
      case BlocStatus.success:
        AppSnackbar.success(context, 'Saved to your cookbook', title: 'Recipe saved');
        // Land the user on the cookbook tab, clearing the generation flow.
        GetIt.I<AppNavigator>().toRecipes();
        break;
      case BlocStatus.error:
        AppSnackbar.error(context, state.failure?.message ?? 'Could not save this recipe.');
        break;
      default:
        break;
    }
  }
}

/// The scrolling content: header, badges, title, ingredients and steps.
class _RecipeBody extends StatelessWidget {
  const _RecipeBody({required this.recipe});

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
              AppTag(label: mood.label, icon: mood.icon, tone: mood.tone),
              if (recipe.cookTimeMinutes != null)
                AppTag(label: '${recipe.cookTimeMinutes} min', icon: Icons.schedule_rounded),
              if (recipe.servings != null) AppTag(label: 'Serves ${recipe.servings}', icon: Icons.group_rounded),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.s5, AppSpacing.s3, AppSpacing.s5, AppSpacing.s0),
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
            padding: const EdgeInsets.fromLTRB(AppSpacing.s5, AppSpacing.s2, AppSpacing.s5, AppSpacing.s0),
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

/// The pinned "Save to cookbook" action, showing progress while saving.
class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.s5, AppSpacing.s3, AppSpacing.s5, AppSpacing.s4),
      decoration: const BoxDecoration(
        color: AppColors.surfaceCanvas,
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: SafeArea(
        top: false,
        child: BlocSelector<SaveRecipeCubit, SaveRecipeState, bool>(
          selector: (SaveRecipeState state) => state.status == BlocStatus.loading,
          builder: (BuildContext context, bool isSaving) {
            return AppSubmitButton(
              label: 'Save to cookbook',
              icon: Icons.bookmark_add_rounded,
              isLoading: isSaving,
              onPressed: onSave,
            );
          },
        ),
      ),
    );
  }
}

/// A back button with a solid circular backing so it stays legible over the
/// photo header.
class _SolidBackButton extends StatelessWidget {
  const _SolidBackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).maybePop(),
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
