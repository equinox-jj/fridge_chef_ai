import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_font_family.dart';
import '../../theme/app_layout.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Shows a styled modal sheet that slides up from the bottom.
///
/// Mirrors the design-system `BottomSheet`: a drag handle, an optional title row
/// with a close button, and a body capped at [AppLayout.screenMax]. Returns the
/// value the sheet is popped with.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    showDragHandle: false,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0x6B15140F), // rgba(21,20,15,0.42)
    builder: (BuildContext context) => _AppBottomSheet<T>(
      title: title,
      child: child,
    ),
  );
}

class _AppBottomSheet<T> extends StatelessWidget {
  const _AppBottomSheet({required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppLayout.screenMax),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.vertical(top: AppRadius.brXl),
            boxShadow: AppShadows.xl,
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.s3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Drag handle.
                  Container(
                    width: AppSpacing.s8, // 40
                    height: 5,
                    margin: const EdgeInsets.only(bottom: AppSpacing.s3),
                    decoration: const BoxDecoration(
                      color: AppPalette.neutral300,
                      borderRadius: BorderRadius.all(AppRadius.brFull),
                    ),
                  ),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.s5,
                        0,
                        AppSpacing.s5,
                        AppSpacing.s3,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              title!,
                              style: const TextStyle(
                                fontFamily: AppFontFamily.display,
                                fontWeight: AppFontWeight.bold,
                                fontSize: AppTextSize.h3,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: AppSpacing.s7, // 32
                              height: AppSpacing.s7,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppPalette.neutral100,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                size: AppTextSize.h3,
                                color: AppPalette.neutral600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s5,
                    ),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
