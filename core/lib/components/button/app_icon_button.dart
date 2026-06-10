import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Visual style of an [AppIconButton].
enum AppIconButtonVariant { plain, solid, tint }

/// Square size preset for an [AppIconButton].
enum AppIconButtonSize { sm, md, lg }

/// A square, round-cornered button holding a single glyph.
///
/// Used for headers, toolbars and inline row actions. [label] is required for
/// accessibility.
class AppIconButton extends StatefulWidget {
  const AppIconButton({
    required this.icon,
    required this.label,
    super.key,
    this.onPressed,
    this.variant = AppIconButtonVariant.plain,
    this.size = AppIconButtonSize.md,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final AppIconButtonSize size;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _pressed = false;
  bool _hovered = false;

  bool get _enabled => widget.onPressed != null;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  void _setHovered(bool value) {
    if (_hovered != value) setState(() => _hovered = value);
  }

  double get _dimension {
    switch (widget.size) {
      case AppIconButtonSize.sm:
        return 36;
      case AppIconButtonSize.md:
        return AppLayout.tapTarget; // 44
      case AppIconButtonSize.lg:
        return 52;
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case AppIconButtonSize.sm:
        return AppTextSize.h3; // 18
      case AppIconButtonSize.md:
        return 21;
      case AppIconButtonSize.lg:
        return AppTextSize.h2; // 22 ~ 24
    }
  }

  Color get _background {
    switch (widget.variant) {
      case AppIconButtonVariant.plain:
        return _hovered && _enabled ? AppPalette.neutral100 : Colors.transparent;
      case AppIconButtonVariant.solid:
        return _hovered && _enabled ? AppColors.primaryHover : AppColors.primary;
      case AppIconButtonVariant.tint:
        return _hovered && _enabled ? AppPalette.green100 : AppColors.primaryTint;
    }
  }

  Color get _foreground {
    switch (widget.variant) {
      case AppIconButtonVariant.plain:
        return AppPalette.neutral700;
      case AppIconButtonVariant.solid:
        return AppColors.textInverse;
      case AppIconButtonVariant.tint:
        return AppColors.primaryText;
    }
  }

  List<BoxShadow>? get _shadow => widget.variant == AppIconButtonVariant.solid && _enabled ? AppShadows.xs : null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      child: MouseRegion(
        cursor: _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => _setHovered(true),
        onExit: (_) => _setHovered(false),
        child: GestureDetector(
          onTapDown: _enabled ? (_) => _setPressed(true) : null,
          onTapUp: _enabled ? (_) => _setPressed(false) : null,
          onTapCancel: _enabled ? () => _setPressed(false) : null,
          onTap: widget.onPressed,
          child: Opacity(
            opacity: _enabled ? 1 : 0.4,
            child: AnimatedScale(
              scale: _pressed && _enabled ? 0.92 : 1,
              duration: AppMotion.fast,
              curve: AppMotion.easeSpring,
              child: AnimatedContainer(
                duration: AppMotion.fast,
                curve: AppMotion.easeOut,
                width: _dimension,
                height: _dimension,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: const BorderRadius.all(AppRadius.brFull),
                  boxShadow: _shadow,
                ),
                child: Icon(widget.icon, size: _iconSize, color: _foreground),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
