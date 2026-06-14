import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

import 'auth_hero_section.dart';

/// Shared scaffold for the auth flow (sign-in / sign-up / forgot-password).
///
/// Renders the green gradient hero with [card] pinned to the bottom. The body
/// scrolls and resizes when the keyboard opens so the focused field is never
/// hidden behind it, and a tap on any empty area dismisses the keyboard — which
/// iOS does not do on its own.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.card,
    super.key,
  });

  /// The form card shown at the bottom of the hero.
  final Widget card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Default (true) so SafeArea reports the keyboard inset and the scroll
      // view can lift the focused field above the keyboard.
      body: GestureDetector(
        onTap: () => context.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.2, -1),
              end: Alignment(0.2, 1),
              stops: <double>[0, 0.46, 1],
              colors: <Color>[
                AppPalette.green600,
                AppPalette.green800,
                AppPalette.neutral900,
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.s7,
                          AppSpacing.s0,
                          AppSpacing.s7,
                          AppSpacing.s8,
                        ),
                        child: Column(
                          children: <Widget>[
                            const Expanded(child: AuthHeroSection()),
                            card,
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
