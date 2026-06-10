import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Selected-state accent for an [AppChoiceChip].
enum AppChoiceChipTone { green, ai }

/// A selectable pill for single- or multi-select grids.
///
/// The mood selector and dietary preference picker are built from these. Pass
/// [selected] to toggle the pressed look and [tone] to switch the selected
/// accent between green and purple (AI).
class AppChoiceChip extends StatefulWidget {
  const AppChoiceChip({
    required this.label,
    super.key,
    this.selected = false,
    this.onSelected,
    this.icon,
    this.tone = AppChoiceChipTone.green,
    this.disabled = false,
  });

  final String label;
  final bool selected;
  final VoidCallback? onSelected;
  final IconData? icon;
  final AppChoiceChipTone tone;
  final bool disabled;

  @override
  State<AppChoiceChip> createState() => _AppChoiceChipState();
}

class _AppChoiceChipState extends State<AppChoiceChip> {
  bool _pressed = false;
  bool _hovered = false;

  bool get _enabled => !widget.disabled && widget.onSelected != null;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  void _setHovered(bool value) {
    if (_hovered != value) setState(() => _hovered = value);
  }

  Color get _background {
    if (widget.selected) {
      return widget.tone == AppChoiceChipTone.ai ? AppPalette.purple50 : AppColors.primaryTint;
    }
    return _hovered && _enabled ? AppPalette.neutral50 : AppColors.surfaceCard;
  }

  Color get _border {
    if (widget.selected) {
      return widget.tone == AppChoiceChipTone.ai ? AppPalette.purple300 : AppPalette.green400;
    }
    return _hovered && _enabled ? AppPalette.neutral400 : AppColors.borderStrong;
  }

  Color get _foreground {
    if (widget.selected) {
      return widget.tone == AppChoiceChipTone.ai ? AppPalette.purple600 : AppPalette.green700;
    }
    return AppPalette.neutral700;
  }

  @override
  Widget build(BuildContext context) {
    final Color fg = _foreground;

    return Semantics(
      button: true,
      enabled: _enabled,
      selected: widget.selected,
      label: widget.label,
      child: MouseRegion(
        cursor: _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => _setHovered(true),
        onExit: (_) => _setHovered(false),
        child: GestureDetector(
          onTapDown: _enabled ? (_) => _setPressed(true) : null,
          onTapUp: _enabled ? (_) => _setPressed(false) : null,
          onTapCancel: _enabled ? () => _setPressed(false) : null,
          onTap: _enabled ? widget.onSelected : null,
          child: Opacity(
            opacity: _enabled ? 1 : 0.45,
            child: AnimatedScale(
              scale: _pressed && _enabled ? 0.96 : 1,
              duration: AppMotion.fast,
              curve: AppMotion.easeSpring,
              child: AnimatedContainer(
                duration: AppMotion.fast,
                curve: AppMotion.easeOut,
                constraints: const BoxConstraints(minHeight: 40),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s4,
                  vertical: AppSpacing.s2 + 2,
                ),
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: const BorderRadius.all(AppRadius.brFull),
                  border: Border.all(color: _border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.s2 - 1,
                  children: <Widget>[
                    if (widget.icon != null) Icon(widget.icon, size: AppTextSize.base, color: fg),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontFamily: AppFontFamily.body,
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: AppTextSize.sm,
                        height: 1,
                        color: fg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
