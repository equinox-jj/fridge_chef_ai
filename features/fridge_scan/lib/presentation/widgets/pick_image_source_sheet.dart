import 'package:core/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:core/constants/image_source_option/image_source_option.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

/// The "Add a photo" sheet: a primary "Take a photo" action above a secondary
/// "Choose from gallery" action, with a note about image compression.
///
/// Mirrors the design-system photo-source sheet. [openSheet] resolves with the
/// chosen [ImageSourceOption], or `null` if the sheet is dismissed.
class PickImageSourceSheet extends StatelessWidget {
  const PickImageSourceSheet({super.key});

  /// Design-system `lg` button height.
  static const double _actionHeight = 56;

  static Future<ImageSourceOption?> openSheet(BuildContext context) {
    return AppBottomSheet.show<ImageSourceOption>(
      context,
      child: const PickImageSourceSheet(),
      isScrollControlled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Shared sizing/typography for the two full-width `lg` actions; each
    // button keeps its own color treatment (primary vs. secondary).
    const Size actionSize = Size.fromHeight(_actionHeight);
    final TextStyle? actionTextStyle = context.textTheme.titleMedium?.copyWith(
      fontSize: AppTextSize.lg,
      fontWeight: AppFontWeight.semiBold,
    );

    return AppBottomSheet(
      title: 'Add a photo',
      spacing: AppSpacing.s3,
      showCloseButton: true,
      children: <Widget>[
        FilledButton.icon(
          onPressed: () => context.pop(
            ImageSourceOption.camera,
          ),
          icon: const Icon(Icons.photo_camera_rounded),
          label: const Text('Take a photo'),
          style: FilledButton.styleFrom(
            minimumSize: actionSize,
            textStyle: actionTextStyle,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => context.pop(
            ImageSourceOption.gallery,
          ),
          icon: const Icon(Icons.photo_library_rounded),
          label: const Text('Choose from gallery'),
          // Design-system "secondary": a white surface with a strong border.
          style: OutlinedButton.styleFrom(
            minimumSize: actionSize,
            textStyle: actionTextStyle,
            foregroundColor: AppColors.textPrimary,
            backgroundColor: AppColors.surfaceCard,
            side: const BorderSide(color: AppColors.borderStrong),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.s1),
          child: Text(
            'Photos are compressed to 1280px before scanning.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textFaint,
            ),
          ),
        ),
      ],
    );
  }
}
