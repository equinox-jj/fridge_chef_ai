import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/components/tag/app_tag.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/ingredient_entity.dart';
import '../../ingredient_category.dart';
import '../../widgets/add_ingredient_sheet.dart';
import '../../widgets/ingredient_tile.dart';
import 'cubit/ingredient_review_cubit.dart';

/// Review step (PRD §4.2.4): the AI's detected ingredients, grouped by
/// category, with per-item quantity steppers, removal, and a way to add
/// anything the model missed. Edits stay in memory and feed recipe generation.
class IngredientReviewPage extends StatelessWidget {
  const IngredientReviewPage({super.key});

  Future<void> _addIngredient(BuildContext context) async {
    final IngredientReviewCubit cubit = context.read<IngredientReviewCubit>();
    final NewIngredient? result = await AddIngredientSheet.openSheet(context);
    if (result == null) return;
    cubit.addIngredient(
      name: result.name,
      quantity: result.quantity,
      unit: result.unit,
      category: result.category,
    );
  }

  void _chooseMood(BuildContext context) {
    // Hand the (edited) ingredient list off to the recipes feature through the
    // navigation contract, mapping each entity onto the decoupled seed type so
    // fridge-scan never has to import recipes (PRD §4.3, §6.2).
    final IngredientReviewCubit cubit = context.read<IngredientReviewCubit>();
    final RecipeGenerationArgs args = RecipeGenerationArgs(
      scanId: cubit.scanId,
      ingredients: cubit.state.items
          .map(
            (IngredientEntity item) => RecipeSeedIngredient(
              name: item.name ?? '',
              quantity: item.quantity,
              unit: item.unit,
            ),
          )
          .where((RecipeSeedIngredient seed) => seed.name.isNotEmpty)
          .toList(),
    );
    GetIt.I<AppNavigator>().toRecipeGeneration(args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      appBar: AppBar(
        title: Text(
          'Ingredients',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        actions: <Widget>[
          BlocSelector<IngredientReviewCubit, IngredientReviewState, int>(
            selector: (IngredientReviewState state) => state.items.length,
            builder: (BuildContext context, int count) {
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.s4),
                child: AppTag(
                  label: '$count found',
                  icon: Icons.check_rounded,
                  tone: AppTagTone.green,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<IngredientReviewCubit, IngredientReviewState>(
          builder: (BuildContext context, IngredientReviewState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: state.items.isEmpty
                      ? _EmptyIngredients(onAdd: () => _addIngredient(context))
                      : _IngredientList(
                          items: state.items,
                          onAdd: () => _addIngredient(context),
                        ),
                ),
                _ContinueBar(
                  enabled: state.items.isNotEmpty,
                  onContinue: () => _chooseMood(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// The scrollable, category-grouped ingredient list with a trailing
/// "add what's missing" row.
class _IngredientList extends StatelessWidget {
  const _IngredientList({
    required this.items,
    required this.onAdd,
  });

  final List<IngredientEntity> items;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final List<_CategoryGroup> groups = _groupByCategory(items);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s5,
        AppSpacing.s2,
        AppSpacing.s5,
        AppSpacing.s5,
      ),
      children: <Widget>[
        Text(
          'Adjust a quantity or remove anything the AI got wrong.',
          style: context.textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: AppSpacing.s2),
        for (final _CategoryGroup group in groups) _CategorySection(group: group),
        const SizedBox(height: AppSpacing.s2),
        _AddMissingRow(onTap: onAdd),
      ],
    );
  }

  /// Buckets [items] by category in the canonical [IngredientCategory] order,
  /// preserving each item's index in the original list so edits map back to the
  /// cubit unambiguously.
  List<_CategoryGroup> _groupByCategory(List<IngredientEntity> items) {
    final Map<IngredientCategory, List<_IndexedIngredient>> buckets = <IngredientCategory, List<_IndexedIngredient>>{};
    for (int i = 0; i < items.length; i++) {
      final IngredientCategory category = IngredientCategory.fromValue(items[i].category);
      buckets.putIfAbsent(category, () => <_IndexedIngredient>[]).add((index: i, item: items[i]));
    }
    return <_CategoryGroup>[
      for (final IngredientCategory category in IngredientCategory.values)
        if (buckets[category] case final List<_IndexedIngredient> entries?) (category: category, entries: entries),
    ];
  }
}

/// A category header followed by its ingredient tiles.
class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.group});

  final _CategoryGroup group;

  @override
  Widget build(BuildContext context) {
    final IngredientReviewCubit cubit = context.read<IngredientReviewCubit>();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.s2,
        children: <Widget>[
          Row(
            spacing: AppSpacing.s2,
            children: <Widget>[
              Text(
                group.category.label.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              Text(
                '${group.entries.length}',
                style: AppTypography.mono.copyWith(
                  fontSize: AppTextSize.xs,
                  color: AppColors.textFaint,
                ),
              ),
            ],
          ),
          for (final _IndexedIngredient entry in group.entries)
            IngredientTile(
              // The index is a stable identity for the row within this build,
              // so removals/edits animate against the right element.
              key: ValueKey<int>(entry.index),
              ingredient: entry.item,
              onIncrement: () => cubit.incrementQuantity(entry.index),
              onDecrement: () => cubit.decrementQuantity(entry.index),
              onRemove: () => cubit.remove(entry.index),
            ),
        ],
      ),
    );
  }
}

/// The dashed "add an ingredient the AI missed" affordance (PRD OQ-1).
class _AddMissingRow extends StatelessWidget {
  const _AddMissingRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryTint,
      borderRadius: const BorderRadius.all(AppRadius.brMd),
      child: InkWell(
        borderRadius: const BorderRadius.all(AppRadius.brMd),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(AppRadius.brMd),
            border: Border.all(color: AppPalette.green300, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.s2,
            children: <Widget>[
              const Icon(Icons.add_rounded, size: AppTextSize.lg, color: AppColors.primaryText),
              Text(
                'Add an ingredient the AI missed',
                style: context.textTheme.titleSmall?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Empty state shown when the user has removed every ingredient.
class _EmptyIngredients extends StatelessWidget {
  const _EmptyIngredients({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppEmptyState(
        icon: Icons.no_meals_rounded,
        title: 'No ingredients left',
        message: 'Add an ingredient to keep going.',
        actionLabel: 'Add an ingredient',
        onAction: onAdd,
      ),
    );
  }
}

/// The pinned bottom action that carries the reviewed list forward.
class _ContinueBar extends StatelessWidget {
  const _ContinueBar({
    required this.enabled,
    required this.onContinue,
  });

  final bool enabled;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
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
        onPressed: enabled ? onContinue : null,
        icon: const Icon(Icons.arrow_forward_rounded),
        iconAlignment: IconAlignment.end,
        label: const Text('Choose a mood'),
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppLayout.tapTarget),
        ),
      ),
    );
  }
}

/// An ingredient paired with its index in the cubit's flat list.
typedef _IndexedIngredient = ({int index, IngredientEntity item});

/// A category and the ingredients that fall under it.
typedef _CategoryGroup = ({IngredientCategory category, List<_IndexedIngredient> entries});
