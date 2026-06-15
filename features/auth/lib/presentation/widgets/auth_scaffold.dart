import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Slim slot-based scaffold for the auth flow.
///
/// Renders a dark canvas background with optional [header], a scrollable
/// [body], and an optional [footer] pinned to the bottom. Tapping any empty
/// area dismisses the keyboard.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.body,
    this.header,
    this.footer,
    super.key,
  });

  final Widget? header;
  final Widget body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ?header,
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s5,
                  ),
                  child: body,
                ),
              ),
              ?footer,
              SizedBox(height: AppSpacing.s3),
            ],
          ),
        ),
      ),
    );
  }
}

/// A simple back-button header for auth screens.
class AuthBackHeader extends StatelessWidget {
  const AuthBackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.s10,
      child: Row(
        children: <Widget>[
          const SizedBox(width: AppSpacing.s2),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

/// A back-button header with a centred title for auth screens.
class AuthTitledHeader extends StatelessWidget {
  const AuthTitledHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.s10,
      child: Row(
        children: <Widget>[
          const SizedBox(width: AppSpacing.s2),
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}
