import 'package:core/components/empty_state/app_empty_state.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// The cookbook tab — the user's saved recipes.
///
/// Listing saved recipes (with offline cache) is a later milestone (PRD §4.4);
/// for now it shows the empty state a freshly-saved-from user returns to.
class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.s4,
        title: Text(
          'Cookbook',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
      ),
      body: const SafeArea(
        top: false,
        child: Center(
          child: AppEmptyState(
            icon: Icons.menu_book_rounded,
            title: 'Your cookbook is empty',
            message: 'Save a recipe and it lands here — ready to cook, even offline.',
          ),
        ),
      ),
    );
  }
}
