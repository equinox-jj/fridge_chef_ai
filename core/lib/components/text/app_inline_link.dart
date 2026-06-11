import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

/// A line of muted [text] followed by a tappable [linkLabel].
///
/// Used for the secondary navigation prompts beneath forms, e.g.
/// "New here? Create an account". A single space is always rendered between the
/// text and the link, so callers need not include a trailing space. Style and
/// alignment default to the design-system values but can be overridden via
/// [textStyle], [linkStyle] and [textAlign].
class AppInlineLink extends StatelessWidget {
  const AppInlineLink({
    required this.text,
    required this.linkLabel,
    required this.onTap,
    super.key,
    this.textStyle,
    this.linkStyle,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final String linkLabel;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final TextStyle? baseStyle =
        textStyle ??
        context.textTheme.bodySmall?.copyWith(
          color: AppColors.textMuted,
        );
    final TextStyle? resolvedLinkStyle =
        linkStyle ??
        context.textTheme.bodySmall?.copyWith(
          color: AppColors.primary,
          fontWeight: AppFontWeight.bold,
        );

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: <InlineSpan>[
          TextSpan(text: '${text.trimRight()} '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: onTap,
              child: Text(linkLabel, style: resolvedLinkStyle),
            ),
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
