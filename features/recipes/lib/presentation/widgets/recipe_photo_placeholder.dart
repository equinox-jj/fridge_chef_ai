import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// A neutral gradient banner standing in for a recipe photo.
///
/// v1.0 recipes have no generated imagery, so cards and the detail header share
/// this placeholder for a consistent look (it's also where a real image would
/// later slot in).
class RecipePhotoPlaceholder extends StatelessWidget {
  const RecipePhotoPlaceholder({
    required this.height,
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColors.backgroundTertiary,
            AppColors.borderSecondary,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.restaurant_rounded,
            size: AppTextSize.h1,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.s1),
          Text(
            'PHOTO PLACEHOLDER',
            style: context.textTheme.labelSmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
