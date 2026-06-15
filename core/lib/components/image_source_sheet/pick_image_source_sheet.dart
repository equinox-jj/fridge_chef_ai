import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../constants/image_source_option/photo_source_choice.dart';
import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../bottom_sheet/app_bottom_sheet.dart';

/// A photo-source sheet: a primary "Take a photo" action above a secondary
/// "Choose from gallery" action, an optional destructive "Remove photo" action,
/// and an optional [caption].
///
/// [openSheet] resolves with the chosen [PhotoSourceChoice], or `null` if the
/// sheet is dismissed.
class PickImageSourceSheet extends StatelessWidget {
  const PickImageSourceSheet({
    super.key,
    this.title = 'Add a photo',
    this.caption,
    this.showRemove = false,
  });

  final String title;
  final String? caption;
  final bool showRemove;

  /// Design-system `lg` button height.
  static const double _actionHeight = 56;

  static Future<PhotoSourceChoice?> openSheet(
    BuildContext context, {
    String title = 'Add a photo',
    String? caption,
    bool showRemove = false,
  }) {
    return AppBottomSheet.show<PhotoSourceChoice>(
      context,
      child: PickImageSourceSheet(
        title: title,
        caption: caption,
        showRemove: showRemove,
      ),
      isScrollControlled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Size actionSize = Size.fromHeight(_actionHeight);
    final TextStyle? actionTextStyle = context.textTheme.titleMedium?.copyWith(
      fontSize: AppTextSize.lg,
      fontWeight: AppFontWeight.semiBold,
    );

    return AppBottomSheet(
      title: title,
      spacing: AppSpacing.s3,
      showCloseButton: true,
      children: <Widget>[
        FilledButton.icon(
          onPressed: () => context.pop(PhotoSourceChoice.camera),
          icon: const Icon(Icons.photo_camera_rounded),
          label: const Text('Take a photo'),
          style: FilledButton.styleFrom(
            minimumSize: actionSize,
            textStyle: actionTextStyle,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () => context.pop(PhotoSourceChoice.gallery),
          icon: const Icon(Icons.photo_library_rounded),
          label: const Text('Choose from gallery'),
          style: OutlinedButton.styleFrom(
            minimumSize: actionSize,
            textStyle: actionTextStyle,
            foregroundColor: AppColors.textPrimary,
            backgroundColor: AppColors.surfaceCard,
            side: const BorderSide(color: AppColors.borderStrong),
          ),
        ),
        if (showRemove)
          TextButton.icon(
            onPressed: () => context.pop(PhotoSourceChoice.remove),
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Remove photo'),
            style: TextButton.styleFrom(
              minimumSize: actionSize,
              textStyle: actionTextStyle,
              foregroundColor: AppColors.danger,
            ),
          ),
        if (caption != null)
          Padding(
            padding: const .only(top: AppSpacing.s1),
            child: Text(
              caption!,
              textAlign: .center,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textFaint,
              ),
            ),
          ),
      ],
    );
  }
}
