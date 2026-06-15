import 'dart:async';

import 'package:flutter/material.dart';

import '../../extensions/context_ext.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// A self-contained countdown for a timed cooking step (PRD §4.3.4).
///
/// Shows the remaining time in monospace, an optional [label] for what is being
/// timed, and play/pause/reset controls. It runs entirely on-device, so it
/// keeps working offline; a single [Timer] ticks once a second and is always
/// cancelled on pause, completion and dispose, so nothing leaks and the widget
/// never rebuilds anything but itself. Operable by tap with pause/resume/reset
/// and labelled controls per the accessibility rules (PRD §7.4).
class AppStepTimer extends StatefulWidget {
  const AppStepTimer({
    required this.seconds,
    super.key,
    this.label,
  });

  /// Starting duration in seconds.
  final int seconds;

  /// What the timer is for (e.g. "Cook rice"); hidden when null/empty.
  final String? label;

  @override
  State<AppStepTimer> createState() => _AppStepTimerState();
}

class _AppStepTimerState extends State<AppStepTimer> {
  /// Remaining seconds and whether the ticker is live. Kept as notifiers so a
  /// tick repaints only the inner [Row] via [ListenableBuilder], not the
  /// surrounding [Container] decoration and border.
  late final ValueNotifier<int> _remaining = ValueNotifier<int>(widget.seconds);
  final ValueNotifier<bool> _running = ValueNotifier<bool>(false);
  Timer? _ticker;

  @override
  void dispose() {
    _ticker?.cancel();
    _remaining.dispose();
    _running.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_remaining.value == 0) return;
    if (_ticker != null) {
      _pause();
    } else {
      _start();
    }
  }

  void _start() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final int next = _remaining.value - 1;
      if (next <= 0) {
        _remaining.value = 0;
        _stopTicker();
      } else {
        _remaining.value = next;
      }
    });
    _running.value = true;
  }

  void _pause() => _stopTicker();

  void _reset() {
    _stopTicker();
    _remaining.value = widget.seconds;
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
    _running.value = false;
  }

  /// "MM:SS" — tabular so the width never jitters as digits change.
  String _formatted(int remaining) {
    final String m = (remaining ~/ 60).toString().padLeft(2, '0');
    final String s = (remaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLabel =
        widget.label != null && widget.label!.trim().isNotEmpty;

    return Container(
      padding: const .symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s2 + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.successTint,
        borderRadius: const .all(AppRadius.brMd),
        border: .all(color: AppDarkPalette.green100),
      ),
      child: ListenableBuilder(
        listenable: Listenable.merge(<Listenable>[_remaining, _running]),
        builder: (BuildContext context, _) {
          final int remaining = _remaining.value;
          final bool running = _running.value;
          final bool done = remaining == 0;

          return Row(
            children: <Widget>[
              Text(
                _formatted(remaining),
                style: AppTypography.mono.copyWith(
                  fontSize: AppTextSize.h2,
                  fontWeight: AppFontWeight.bold,
                  color: done ? AppColors.actionText : AppColors.primaryText,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
              if (hasLabel) ...<Widget>[
                const SizedBox(width: AppSpacing.s3),
                Flexible(
                  child: Text(
                    widget.label!,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              _TimerButton(
                icon: running ? Icons.pause_rounded : Icons.play_arrow_rounded,
                tooltip: running ? 'Pause timer' : 'Start timer',
                primary: true,
                onPressed: done ? null : _toggle,
              ),
              const SizedBox(width: AppSpacing.s2),
              _TimerButton(
                icon: Icons.refresh_rounded,
                tooltip: 'Reset timer',
                onPressed: remaining == widget.seconds && !running
                    ? null
                    : _reset,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A round play/pause/reset control inside [AppStepTimer].
class _TimerButton extends StatelessWidget {
  const _TimerButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.primary = false,
  });

  static const double _size = 40;

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    final Color background = primary
        ? AppColors.primary
        : AppColors.surfaceCard;
    final Color foreground = primary
        ? AppColors.onPrimary
        : AppColors.primaryText;

    return Material(
      color: enabled ? background : AppColors.surfaceSunken,
      shape: const CircleBorder(),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          shape: .circle,
          boxShadow: primary && enabled ? AppShadows.primary : AppShadows.xs,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Tooltip(
            message: tooltip,
            child: SizedBox(
              width: _size,
              height: _size,
              child: Icon(
                icon,
                size: AppTextSize.h3,
                color: enabled ? foreground : AppColors.textFaint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
