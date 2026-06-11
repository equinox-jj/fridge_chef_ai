import 'package:core/theme/app_spacing.dart';
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
      children: <Widget>[
        Padding(
          padding: const .symmetric(
            horizontal: AppSpacing.s2,
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            spacing: 10,
            children: <Widget>[
              Flexible(
                child: Text('Add a Photo'),
              ),
              Flexible(
                child: IconButton(
                  onPressed: () => (),
                  icon: Icon(
                    Icons.close_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
