import 'package:core/components/ai_loader/app_ai_loader.dart';
import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/tag/app_tag.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_route.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../args/recipe_detail_args.dart';
import '../../dietary_preference.dart';
import 'bloc/recipe_generation_bloc.dart';
import 'widgets/mood_picker_view.dart';
import 'widgets/recipe_results_view.dart';

/// Hosts the whole generation flow in one route: the mood picker, the "writing
/// recipes" loader, and the three-recipe results — swapped by
/// [RecipeGenStatus] so the single [RecipeGenerationBloc] owns the session.
class GenerateRecipesPage extends StatelessWidget {
  const GenerateRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      appBar: AppBar(
        title: BlocSelector<RecipeGenerationBloc, RecipeGenerationState, RecipeGenStatus>(
          selector: (RecipeGenerationState state) => state.status,
          builder: (BuildContext context, RecipeGenStatus status) {
            return Text(
              _titleFor(status),
              style: context.textTheme.headlineMedium?.copyWith(
                fontFamily: AppFontFamily.display,
                fontWeight: AppFontWeight.bold,
              ),
            );
          },
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.s4),
            child: Center(
              child: AppTag(label: 'Gemini', icon: Icons.auto_awesome_rounded, tone: AppTagTone.purple),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<RecipeGenerationBloc, RecipeGenerationState>(
          builder: (BuildContext context, RecipeGenerationState state) {
            switch (state.status) {
              case RecipeGenStatus.selecting:
                return const MoodPickerView();
              case RecipeGenStatus.generating:
                return _GeneratingView(state: state);
              case RecipeGenStatus.results:
                return RecipeResultsView(
                  recipes: state.recipes,
                  onRegenerate: () =>
                      context.read<RecipeGenerationBloc>().add(const RecipeGenerationEvent.generateRequested()),
                  onOpenRecipe: (int index) {
                    context.push(
                      AppRoute.recipeDetailPath,
                      extra: RecipeDetailArgs(recipe: state.recipes[index], scanId: state.scanId),
                    );
                  },
                );
              case RecipeGenStatus.error:
                return _ErrorView(
                  message: state.failure?.message ?? 'Something went wrong while writing your recipes.',
                  onRetry: () =>
                      context.read<RecipeGenerationBloc>().add(const RecipeGenerationEvent.generateRequested()),
                );
            }
          },
        ),
      ),
    );
  }

  String _titleFor(RecipeGenStatus status) {
    switch (status) {
      case RecipeGenStatus.selecting:
        return 'Pick a mood';
      case RecipeGenStatus.generating:
        return 'Writing recipes';
      case RecipeGenStatus.results:
      case RecipeGenStatus.error:
        return '3 recipes';
    }
  }
}

/// The Gemini "writing recipes" loader, with copy that reflects the chosen
/// mood, diet and ingredient count.
class _GeneratingView extends StatelessWidget {
  const _GeneratingView({required this.state});

  final RecipeGenerationState state;

  @override
  Widget build(BuildContext context) {
    final String mood = state.mood?.label.toLowerCase() ?? 'tasty';
    final bool hasDiet = state.dietaryPreference != DietaryPreference.none;
    final String dietPhrase = hasDiet ? '${state.dietaryPreference.label.toLowerCase()} ' : '';
    final int count = state.ingredients.length;

    return AppAiLoader(
      title: 'Writing recipes…',
      subtitle: 'Gemini is creating 3 $dietPhrase$mood recipes from your $count ingredients.',
    );
  }
}

/// Shown when generation fails — a friendly message and a retry.
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppEmptyState(
        icon: Icons.error_outline_rounded,
        title: "Couldn't write recipes",
        message: message,
        actionLabel: 'Try again',
        actionIcon: Icons.refresh_rounded,
        onAction: onRetry,
      ),
    );
  }
}
