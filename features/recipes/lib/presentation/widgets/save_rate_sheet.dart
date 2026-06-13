import 'package:core/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:core/components/star_rating/app_star_rating.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_layout.dart';
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
    return AppBottomSheet.show<RecipeRating>(context, child: const SaveRateSheet());
  }

  @override
  State<SaveRateSheet> createState() => _SaveRateSheetState();
}

class _SaveRateSheetState extends State<SaveRateSheet> {
  final TextEditingController _noteController = TextEditingController();

  /// The star rating; a notifier so tapping a star rebuilds only the rating
  /// control and the Done button, leaving the note field untouched.
  final ValueNotifier<int> _stars = ValueNotifier<int>(0);

  @override
  void dispose() {
    _noteController.dispose();
    _stars.dispose();
    super.dispose();
  }

  void _submit() {
    if (_stars.value <= 0) return;
    context.pop((stars: _stars.value, note: _noteController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Save to cookbook',
      centerTitle: true,
      children: <Widget>[
        Text(
          'How did it turn out?',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        ),
        Center(
          child: ValueListenableBuilder<int>(
            valueListenable: _stars,
            builder: (_, int stars, _) => AppStarRating(
              value: stars,
              size: AppStarRatingSize.lg,
              onChanged: (int value) => _stars.value = value,
            ),
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
        ValueListenableBuilder<int>(
          valueListenable: _stars,
          builder: (_, int stars, _) => FilledButton.icon(
            onPressed: stars > 0 ? _submit : null,
            icon: const Icon(Icons.check_rounded),
            label: const Text('Done'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(AppLayout.tapTarget),
            ),
          ),
        ),
      ],
    );
  }
}
