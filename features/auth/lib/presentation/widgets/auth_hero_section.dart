import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// The branded hero block that sits above the sign-in card.
///
/// a translucent app mark, the
/// display headline and a muted supporting line, all on the green gradient.
class AuthHeroSection extends StatelessWidget {
  const AuthHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: AppSpacing.s9,
          height: AppSpacing.s9,
          decoration: BoxDecoration(
            color: AppColors.textInverse.withValues(alpha: 0.14),
            borderRadius: const BorderRadius.all(AppRadius.brLg),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.kitchen_outlined,
            size: AppTextSize.display,
            color: AppColors.textInverse,
          ),
        ),
        const SizedBox(height: AppSpacing.s3),
        Text(
          'Snap your fridge.\nCook what you have.',
          style: context.textTheme.displayMedium?.copyWith(
            color: AppColors.textInverse,
          ),
        ),
        const SizedBox(height: AppSpacing.s2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            "FridgeScan reads what's inside and writes three recipes you "
            'can make tonight.',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    );
  }
}
