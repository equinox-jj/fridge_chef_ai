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
  late int _remaining = widget.seconds;
  Timer? _ticker;

  bool get _running => _ticker != null;
  bool get _done => _remaining == 0;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_done) return;
    if (_running) {
      _pause();
    } else {
      _start();
    }
  }

  void _start() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _remaining--;
        if (_remaining <= 0) {
          _remaining = 0;
          _stopTicker();
        }
      });
    });
    setState(() {});
  }

  void _pause() {
    _stopTicker();
    setState(() {});
  }

  void _reset() {
    _stopTicker();
    setState(() => _remaining = widget.seconds);
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  /// "MM:SS" — tabular so the width never jitters as digits change.
  String get _formatted {
    final String m = (_remaining ~/ 60).toString().padLeft(2, '0');
    final String s = (_remaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLabel = widget.label != null && widget.label!.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s2 + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.successTint,
        borderRadius: const BorderRadius.all(AppRadius.brMd),
        border: Border.all(color: AppPalette.green100),
      ),
      child: Row(
        children: <Widget>[
          Text(
            _formatted,
            style: AppTypography.mono.copyWith(
              fontSize: AppTextSize.h2,
              fontWeight: AppFontWeight.bold,
              color: _done ? AppColors.actionText : AppColors.primaryText,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
          if (hasLabel) ...<Widget>[
            const SizedBox(width: AppSpacing.s3),
            Flexible(
              child: Text(
                widget.label!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelLarge?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ],
          const Spacer(),
          _TimerButton(
            icon: _running ? Icons.pause_rounded : Icons.play_arrow_rounded,
            tooltip: _running ? 'Pause timer' : 'Start timer',
            primary: true,
            onPressed: _done ? null : _toggle,
          ),
          const SizedBox(width: AppSpacing.s2),
          _TimerButton(
            icon: Icons.refresh_rounded,
            tooltip: 'Reset timer',
            onPressed: _remaining == widget.seconds && !_running ? null : _reset,
          ),
        ],
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
    final Color background = primary ? AppColors.primary : AppColors.surfaceCard;
    final Color foreground = primary ? AppColors.onPrimary : AppColors.primaryText;

    return Material(
      color: enabled ? background : AppColors.surfaceSunken,
      shape: const CircleBorder(),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
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
