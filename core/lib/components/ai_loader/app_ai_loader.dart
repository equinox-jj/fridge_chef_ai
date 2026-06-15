import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';

/// Full-bleed "AI is thinking" indicator for Gemini moments (fridge vision,
/// recipe generation, …).
///
/// A pulsing purple gradient orb above a [title]/[subtitle] pair and an
/// indeterminate progress bar — labelled progress, never a bare spinner
/// (PRD §7.1). Reused anywhere the app is waiting on the model, so the AI
/// "voice" stays consistent across features.
///
/// The pulse runs on a single [AnimationController] and is wrapped in a
/// [RepaintBoundary] so the animation never repaints the surrounding screen.
class AppAiLoader extends StatefulWidget {
  const AppAiLoader({
    required this.title,
    super.key,
    this.subtitle,
    this.icon = Icons.auto_awesome_rounded,
  });

  /// Headline describing the current step (e.g. "Reading your fridge…").
  final String title;

  /// Optional supporting line (e.g. what the model is doing right now).
  final String? subtitle;

  /// Glyph shown inside the orb.
  final IconData icon;

  @override
  State<AppAiLoader> createState() => _AppAiLoaderState();
}

class _AppAiLoaderState extends State<AppAiLoader>
    with SingleTickerProviderStateMixin {
  static const Duration _pulseDuration = Duration(milliseconds: 1800);
  static const double _orbSize = 96;
  static const double _progressWidth = 200;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _pulseDuration,
  )..repeat(reverse: true);

  late final Animation<double> _pulse = Tween<double>(begin: 1, end: 1.08)
      .animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .symmetric(
          horizontal: AppSpacing.s8,
        ),
        child: Column(
          mainAxisSize: .min,
          children: <Widget>[
            RepaintBoundary(
              child: ScaleTransition(
                scale: _pulse,
                child: Container(
                  width: _orbSize,
                  height: _orbSize,
                  alignment: .center,
                  decoration: const BoxDecoration(
                    shape: .circle,
                    gradient: LinearGradient(
                      begin: .topLeft,
                      end: .bottomRight,
                      colors: <Color>[
                        AppDarkPalette.purple400,
                        AppDarkPalette.purple600,
                      ],
                    ),
                    boxShadow: AppShadows.ai,
                  ),
                  child: Icon(
                    widget.icon,
                    size: AppSpacing.s11,
                    color: AppColors.textInverse,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            Text(
              widget.title,
              textAlign: .center,
              style: context.textTheme.displaySmall,
            ),
            if (widget.subtitle != null) ...<Widget>[
              const SizedBox(height: AppSpacing.s2),
              Text(
                widget.subtitle!,
                textAlign: .center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.s6),
            const SizedBox(
              width: _progressWidth,
              child: LinearProgressIndicator(
                minHeight: 6,
                backgroundColor: AppDarkPalette.neutral200,
                color: AppColors.ai,
                borderRadius: .all(AppRadius.brFull),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
