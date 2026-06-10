import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// An on/off toggle for settings rows.
///
/// The track turns [AppColors.primary] when on and the thumb slides with a
/// springy motion. Pass [label] for an accessible name.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.disabled = false,
    this.label,
  });

  static const double _width = 46;
  static const double _height = 28;
  static const double _padding = 3;

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool disabled;
  final String? label;

  bool get _enabled => !disabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    const double thumb = _height - 2 * _padding;

    return Semantics(
      toggled: value,
      label: label,
      child: MouseRegion(
        cursor: _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: _enabled ? () => onChanged?.call(!value) : null,
          child: Opacity(
            opacity: disabled ? 0.5 : 1,
            child: AnimatedContainer(
              duration: AppMotion.base,
              curve: AppMotion.easeOut,
              width: _width,
              height: _height,
              padding: const EdgeInsets.all(_padding),
              decoration: BoxDecoration(
                color: value ? AppColors.primary : AppPalette.neutral300,
                borderRadius: const .all(AppRadius.brFull),
              ),
              child: AnimatedAlign(
                duration: AppMotion.base,
                curve: AppMotion.easeSpring,
                alignment: value ? .centerRight : .centerLeft,
                child: Container(
                  width: thumb,
                  height: thumb,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceCard,
                    shape: .circle,
                    boxShadow: AppShadows.sm,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
