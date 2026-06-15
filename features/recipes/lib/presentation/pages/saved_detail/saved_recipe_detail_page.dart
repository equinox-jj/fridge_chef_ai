import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/loader/app_loading_indicator.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/recipe_entity.dart';
import '../detail/widgets/recipe_detail_content.dart';
import 'cubit/recipe_detail_cubit.dart';

/// A saved recipe opened from the cookbook: the same recipe view as the
/// generation flow, minus the "Save to cookbook" bar (it's already saved).
///
/// The full recipe is loaded by id (cache-first via [RecipeDetailCubit]), so it
/// reads offline once it's been opened online; a cache miss while offline shows
/// a retry-able message rather than a blank screen.
class SavedRecipeDetailPage extends StatelessWidget {
  const SavedRecipeDetailPage({super.key});

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
      body: BlocBuilder<RecipeDetailCubit, RecipeDetailState>(
        builder: (BuildContext context, RecipeDetailState state) {
          final RecipeEntity? recipe = state.recipe;
          switch (state.status) {
            case BlocStatus.initial:
            case BlocStatus.loading:
              return const AppLoadingIndicator();
            case BlocStatus.empty:
            case BlocStatus.error:
              return Center(
                child: AppEmptyState(
                  icon: Icons.cloud_off_rounded,
                  title: "Couldn't open this recipe",
                  message:
                      state.failure?.message ??
                      'Something went wrong. Please try again.',
                  actionLabel: 'Try again',
                  actionIcon: Icons.refresh_rounded,
                  onAction: () => context.read<RecipeDetailCubit>().load(),
                ),
              );
            case BlocStatus.success:
              // Defensive: success always carries a recipe; fall back to the
              // loader rather than crashing if that ever isn't the case.
              if (recipe == null) return const AppLoadingIndicator();
              return RecipeDetailContent(recipe: recipe);
          }
        },
      ),
    );
  }
}
