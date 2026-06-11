import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

class PickImageSourceSheet extends StatelessWidget {
  const PickImageSourceSheet({super.key});

  static Future<T?> openSheet<T>(BuildContext context) => showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (BuildContext context) => PickImageSourceSheet(),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      spacing: 10,
      children: <Widget>[
        Padding(
          padding: const .symmetric(
            horizontal: AppSpacing.s4,
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            spacing: 10,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Add a Photo',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: AppFontWeight.bold,
                    fontFamily: AppFontFamily.display,
                  ),
                ),
              ),
              Flexible(
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.close_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: context.colorScheme.onSurfaceVariant.withValues(
                      alpha: .15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const .symmetric(
            horizontal: AppSpacing.s4,
          ),
          child: ElevatedButton.icon(
            onPressed: () => (),
            label: Text('Take a photo'),
            icon: Icon(Icons.camera_alt_outlined),
            style: ElevatedButton.styleFrom(
              textStyle: context.textTheme.titleMedium?.copyWith(
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const .symmetric(
            horizontal: AppSpacing.s4,
          ),
          child: OutlinedButton.icon(
            onPressed: () => (),
            label: Text('Choose from gallery'),
            icon: Icon(Icons.photo_outlined),
            style: OutlinedButton.styleFrom(
              textStyle: context.textTheme.titleMedium?.copyWith(
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: .symmetric(
            horizontal: AppSpacing.s4,
          ),
          child: Text(
            'Photos are compressed to 1280px before scanning.',
            textAlign: .center,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.s2),
      ],
    );
  }
}
