import 'package:core/components/button/app_submit_button.dart';
import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/router/app_navigator.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_motion.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'cubit/onboarding_cubit.dart';
import 'cubit/onboarding_state.dart';
import 'widgets/onboarding_page_content.dart';
import 'widgets/onboarding_page_indicator.dart';

/// The three value-prop pages — promise, Gemini moment, dietary setup — shown on
/// first run. Swipeable, skippable at any step, and finishing on either "Skip"
/// or "Get started" persists completion before handing off to the app.
const List<OnboardingStep> _steps = <OnboardingStep>[
  OnboardingStep(
    icon: Icons.photo_camera_rounded,
    title: 'Snap your fridge',
    body: 'Take one photo — Gemini spots every ingredient inside.',
  ),
  OnboardingStep(
    icon: Icons.auto_awesome_rounded,
    title: 'Three recipes, your mood',
    body: 'Pick a mood and get three dishes you can cook right now.',
    isGeminiMoment: true,
  ),
  OnboardingStep(
    icon: Icons.eco_rounded,
    title: 'How do you eat?',
    body: "Pick a preference and we'll fold it into every recipe you get.",
    isDietarySetup: true,
  ),
];

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (OnboardingState p, OnboardingState c) =>
            p.finishStatus != c.finishStatus,
        listener: _onFinishStatusChanged,
        child: const SafeArea(child: _OnboardingView()),
      ),
    );
  }

  void _onFinishStatusChanged(BuildContext context, OnboardingState state) {
    switch (state.finishStatus) {
      case BlocStatus.success:
        context.read<AppNavigator>().goToDashboard();
      case BlocStatus.error:
        AppSnackbar.error(context, state.finishFailure?.message ?? '');
      default:
        break;
    }
  }
}

/// Owns the [PageController] and renders the header, pages, dots and primary
/// button. The cubit holds the page index and dietary choice; this widget only
/// drives the scroll and reports changes back.
class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  OnboardingCubit get _cubit => context.read<OnboardingCubit>();

  bool _isLastPage(int index) => index == _steps.length - 1;

  void _onPrimaryPressed(int pageIndex) {
    if (_isLastPage(pageIndex)) {
      _cubit.finishWithPreference();
      return;
    }
    _controller.nextPage(duration: AppMotion.base, curve: AppMotion.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (BuildContext context, OnboardingState state) {
        final bool isBusy = state.finishStatus == BlocStatus.loading;
        final bool isLast = _isLastPage(state.pageIndex);

        return Column(
          children: <Widget>[
            SizedBox(
              height: AppLayout.headerHeight,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s3,
                  ),
                  child: TextButton(
                    onPressed: isBusy ? null : _cubit.finishSkipping,
                    child: const Text('Skip'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: _cubit.pageChanged,
                itemCount: _steps.length,
                itemBuilder: (BuildContext context, int index) {
                  final OnboardingStep step = _steps[index];
                  return OnboardingPageContent(
                    step: step,
                    dietarySelected: state.dietaryPreference,
                    onDietarySelected: _cubit.selectDietaryPreference,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s5,
                AppSpacing.s0,
                AppSpacing.s5,
                AppSpacing.s7,
              ),
              child: Column(
                children: <Widget>[
                  OnboardingPageIndicator(
                    count: _steps.length,
                    activeIndex: state.pageIndex,
                  ),
                  const SizedBox(height: AppSpacing.s5),
                  AppSubmitButton(
                    label: isLast ? 'Get started' : 'Next',
                    icon: isLast
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                    isLoading: isBusy,
                    onPressed: () => _onPrimaryPressed(state.pageIndex),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
