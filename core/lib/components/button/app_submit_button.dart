import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// A full-width [FilledButton] for the primary action of a form.
///
/// Shows a leading [icon] and [label] when idle, and a centered spinner while
/// [isLoading]. The button is disabled while loading; pass `onPressed: null` to
/// disable it otherwise.
class AppSubmitButton extends StatelessWidget {
  const AppSubmitButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
    this.isLoading = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppLayout.tapTarget),
        ),
        icon: isLoading ? const SizedBox.shrink() : Icon(icon, size: AppTextSize.h3),
        label: isLoading
            ? const SizedBox(
                width: AppSpacing.s5,
                height: AppSpacing.s5,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.onPrimary,
                ),
              )
            : Text(label),
      ),
    );
  }
}
