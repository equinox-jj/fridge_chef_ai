import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/usecases/has_completed_onboarding_usecase.dart';
import 'splash_state.dart';

/// Decides where the app starts: onboarding on first run, otherwise the app.
///
/// Reading the flag is near-instant, so a minimum brand-mark duration is held
/// in parallel — the splash never flickers past before the user registers it.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(
    this._hasCompletedOnboarding, {
    this.minBrandDuration = const Duration(milliseconds: 1600),
  }) : super(const SplashState());

  final HasCompletedOnboardingUseCase _hasCompletedOnboarding;

  /// How long the brand mark stays up before routing, even when the flag
  /// resolves sooner. Injectable so tests can drive it with [Duration.zero].
  final Duration minBrandDuration;

  Future<void> resolveStartDestination() async {
    final Future<void> minDuration = Future<void>.delayed(minBrandDuration);
    final Either<Failure, bool> result = await _hasCompletedOnboarding(
      const NoParams(),
    );
    await minDuration;

    if (isClosed) return;

    // A read failure is treated as "not completed" so a new user still gets the
    // onboarding rather than being dropped straight into the app.
    final bool completed = result.getOrElse((Failure _) => false);

    emit(
      state.copyWith(
        destination: completed
            ? SplashDestination.home
            : SplashDestination.onboarding,
      ),
    );
  }
}
