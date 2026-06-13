import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/recipe_entity.dart';
import '../../widgets/save_rate_sheet.dart';
import 'cubit/save_recipe_cubit.dart';
import 'widgets/recipe_detail_content.dart';

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
          child: RecipeDetailBackButton(),
        ),
      ),
      body: BlocListener<SaveRecipeCubit, SaveRecipeState>(
        listenWhen: (SaveRecipeState p, SaveRecipeState c) => p.status != c.status,
        listener: _onSaveStateChanged,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: RecipeDetailContent(recipe: recipe),
            ),
            _SaveBar(onSave: () => _onSave(context)),
          ],
        ),
      ),
    );
  }

  void _onSaveStateChanged(BuildContext context, SaveRecipeState state) {
    switch (state.status) {
      case BlocStatus.success:
        AppSnackbar.success(
          context,
          'Saved to your cookbook',
          title: 'Recipe saved',
        );
        // Land the user on the cookbook tab, clearing the generation flow.
        GetIt.I<AppNavigator>().toRecipes();
        break;
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.failure?.message ?? 'Could not save this recipe.',
        );
        break;
      default:
        break;
    }
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
