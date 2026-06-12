import 'package:core/components/star_rating/app_star_rating.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

/// The rating and note the user gives a recipe when saving it.
typedef RecipeRating = ({int stars, String note});

/// Bottom sheet for rating a recipe on save (PRD §4.4.1): a 1–5 star control
/// and an optional note. [openSheet] resolves with the entered [RecipeRating],
/// or null if dismissed without confirming.
class SaveRateSheet extends StatefulWidget {
  const SaveRateSheet({super.key});

  static Future<RecipeRating?> openSheet(BuildContext context) {
    return showModalBottomSheet<RecipeRating>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) => const SaveRateSheet(),
    );
  }

  @override
  State<SaveRateSheet> createState() => _SaveRateSheetState();
}

class _SaveRateSheetState extends State<SaveRateSheet> {
  final TextEditingController _noteController = TextEditingController();
  int _stars = 0;

  bool get _canSubmit => _stars > 0;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_canSubmit) return;
    context.pop((stars: _stars, note: _noteController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s5,
            AppSpacing.s0,
            AppSpacing.s5,
            AppSpacing.s6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s4,
            children: <Widget>[
              Text(
                'Save to cookbook',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontFamily: AppFontFamily.display,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              Text(
                'How did it turn out?',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
              ),
              Center(
                child: AppStarRating(
                  value: _stars,
                  size: AppStarRatingSize.lg,
                  onChanged: (int value) => setState(() => _stars = value),
                ),
              ),
              TextField(
                controller: _noteController,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Add a note (optional)',
                  hintText: 'Great with extra lemon…',
                ),
              ),
              FilledButton.icon(
                onPressed: _canSubmit ? _submit : null,
                icon: const Icon(Icons.check_rounded),
                label: const Text('Done'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(AppLayout.tapTarget),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
