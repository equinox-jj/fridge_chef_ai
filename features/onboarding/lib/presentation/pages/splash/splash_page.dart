import 'package:core/extensions/context_ext.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_motion.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_shadows.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'cubit/splash_cubit.dart';
import 'cubit/splash_state.dart';

/// First screen on launch: the brand mark while the app resolves where to go.
///
/// The [SplashCubit] decides the destination (provided by the route); this page
/// only renders the brand moment and forwards the user once it is resolved.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listenWhen: (SplashState p, SplashState c) =>
            p.destination != c.destination,
        listener: _onDestinationResolved,
        child: const SafeArea(
          child: Stack(
            children: <Widget>[
              Center(child: _SplashBrand()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.s8),
                  child: _VersionLabel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDestinationResolved(BuildContext context, SplashState state) {
    final AppNavigator navigator = context.read<AppNavigator>();
    switch (state.destination) {
      case SplashDestination.onboarding:
        navigator.goToOnboarding();
      case SplashDestination.home:
        navigator.goToDashboard();
      case null:
        break;
    }
  }
}

/// The pulsing app mark over the product name and tagline.
class _SplashBrand extends StatelessWidget {
  const _SplashBrand();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const _PulsingBrandMark(),
        const SizedBox(height: AppSpacing.s5),
        Text('FridgeChef', style: context.textTheme.displayLarge),
        const SizedBox(height: AppSpacing.s1),
        Text(
          'Cook what you have',
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

/// The rounded brand tile that gently pulses while the app boots.
class _PulsingBrandMark extends StatefulWidget {
  const _PulsingBrandMark();

  @override
  State<_PulsingBrandMark> createState() => _PulsingBrandMarkState();
}

class _PulsingBrandMarkState extends State<_PulsingBrandMark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  late final Animation<double> _scale = Tween<double>(begin: 1, end: 1.06)
      .animate(
        CurvedAnimation(parent: _controller, curve: AppMotion.easeInOut),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: AppSpacing.s12,
        height: AppSpacing.s12,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[AppPalette.green500, AppPalette.green700],
          ),
          borderRadius: BorderRadius.all(AppRadius.brXl),
          boxShadow: AppShadows.primary,
        ),
        child: const Icon(
          Icons.kitchen_rounded,
          color: AppColors.textInverse,
          size: AppTextSize.display,
        ),
      ),
    );
  }
}

/// The mono version stamp pinned to the bottom of the splash.
class _VersionLabel extends StatelessWidget {
  const _VersionLabel();

  @override
  Widget build(BuildContext context) {
    return Text(
      'v1.0',
      style: AppTypography.mono.copyWith(
        fontSize: AppTextSize.xs,
        color: AppColors.textFaint,
      ),
    );
  }
}
