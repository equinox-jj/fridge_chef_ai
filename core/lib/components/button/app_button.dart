import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_font_family.dart';
import '../../theme/app_motion.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Visual style of an [AppButton].
///
/// Mirrors the design-system variants:
/// primary (green) · ai (purple Gemini) · secondary · ghost · tint · danger ·
/// dangerGhost.
enum AppButtonVariant { primary, ai, secondary, ghost, tint, danger, dangerGhost }

/// Height/padding/type preset for an [AppButton].
enum AppButtonSize { sm, md, lg }

/// The primary tappable action.
///
/// A pill-shaped button with hover, pressed (scale) and disabled states. Pass a
/// leading [icon] and/or trailing [iconRight], and [block] to fill the width.
class AppButton extends StatefulWidget {
  const AppButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.block = false,
    this.icon,
    this.iconRight,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool block;
  final IconData? icon;
  final IconData? iconRight;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;
  bool _hovered = false;

  bool get _enabled => widget.onPressed != null;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  void _setHovered(bool value) {
    if (_hovered != value) setState(() => _hovered = value);
  }

  Color _resolve(Color base, Color hover, Color active) {
    if (!_enabled) return base;
    if (_pressed) return active;
    if (_hovered) return hover;
    return base;
  }

  Color get _background {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return _resolve(AppColors.primary, AppColors.primaryHover, AppColors.primaryActive);
      case AppButtonVariant.ai:
        return _resolve(AppColors.ai, AppColors.aiStrong, AppPalette.purple700);
      case AppButtonVariant.secondary:
        return _resolve(AppColors.surfaceCard, AppPalette.neutral50, AppPalette.neutral100);
      case AppButtonVariant.ghost:
        return _resolve(Colors.transparent, AppPalette.neutral100, AppPalette.neutral200);
      case AppButtonVariant.tint:
        return _resolve(AppColors.primaryTint, AppPalette.green100, AppPalette.green200);
      case AppButtonVariant.danger:
        return _resolve(AppColors.danger, AppPalette.coral700, AppPalette.coral700);
      case AppButtonVariant.dangerGhost:
        return _resolve(Colors.transparent, AppPalette.coral50, AppPalette.coral100);
    }
  }

  Color get _foreground {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppColors.onPrimary;
      case AppButtonVariant.ai:
      case AppButtonVariant.danger:
        return AppColors.textInverse;
      case AppButtonVariant.secondary:
        return AppPalette.neutral900;
      case AppButtonVariant.ghost:
        return AppPalette.neutral800;
      case AppButtonVariant.tint:
        return AppColors.primaryText;
      case AppButtonVariant.dangerGhost:
        return AppColors.dangerText;
    }
  }

  BoxBorder? get _border =>
      widget.variant == AppButtonVariant.secondary ? Border.all(color: AppColors.borderStrong) : null;

  List<BoxShadow>? get _shadow {
    if (!_enabled) return null;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppShadows.xs;
      case AppButtonVariant.ai:
        return AppShadows.ai;
      // ignore: no_default_cases
      default:
        return null;
    }
  }

  double get _height {
    switch (widget.size) {
      case AppButtonSize.sm:
        return 38;
      case AppButtonSize.md:
        return 48;
      case AppButtonSize.lg:
        return 56;
    }
  }

  double get _padX {
    switch (widget.size) {
      case AppButtonSize.sm:
        return AppSpacing.s4;
      case AppButtonSize.md:
        return 22;
      case AppButtonSize.lg:
        return 28;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case AppButtonSize.sm:
        return AppTextSize.sm;
      case AppButtonSize.md:
        return AppTextSize.base;
      case AppButtonSize.lg:
        return AppTextSize.lg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color fg = _foreground;
    final double iconSize = _fontSize * 1.25;

    final Widget content = Row(
      mainAxisSize: widget.block ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.s2,
      children: <Widget>[
        if (widget.icon != null) Icon(widget.icon, size: iconSize, color: fg),
        Text(
          widget.label,
          style: TextStyle(
            fontFamily: AppFontFamily.body,
            fontWeight: AppFontWeight.semiBold,
            fontSize: _fontSize,
            height: 1,
            color: fg,
          ),
        ),
        if (widget.iconRight != null) Icon(widget.iconRight, size: iconSize, color: fg),
      ],
    );

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
              scale: _pressed && _enabled ? 0.97 : 1,
              duration: AppMotion.fast,
              curve: AppMotion.easeSpring,
              child: AnimatedContainer(
                duration: AppMotion.fast,
                curve: AppMotion.easeOut,
                height: _height,
                width: widget.block ? double.infinity : null,
                padding: EdgeInsets.symmetric(horizontal: _padX),
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: const BorderRadius.all(AppRadius.brFull),
                  border: _border,
                  boxShadow: _shadow,
                ),
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
