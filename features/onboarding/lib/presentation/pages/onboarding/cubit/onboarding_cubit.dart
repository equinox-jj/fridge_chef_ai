import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/usecases/complete_onboarding_usecase.dart';
import 'onboarding_state.dart';

/// Drives the three-page onboarding: tracks the current page, the dietary
/// choice, and persisting completion when the user finishes or skips.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._completeOnboarding) : super(const OnboardingState());

  final CompleteOnboardingUseCase _completeOnboarding;

  void pageChanged(int index) => emit(state.copyWith(pageIndex: index));

  void selectDietaryPreference(DietaryPreference preference) {
    emit(state.copyWith(dietaryPreference: preference));
  }

  /// "Get started" — completes onboarding, recording the chosen preference.
  Future<void> finishWithPreference() => _finish(state.dietaryPreference);

  /// "Skip" — completes onboarding without recording a dietary preference.
  Future<void> finishSkipping() => _finish(null);

  Future<void> _finish(DietaryPreference? preference) async {
    emit(state.copyWith(finishStatus: BlocStatus.loading));

    final Either<Failure, Unit> result = await _completeOnboarding(
      CompleteOnboardingParams(dietaryPreference: preference),
    );

    if (isClosed) return;

    emit(
      result.fold(
        (Failure l) => state.copyWith(
          finishStatus: BlocStatus.error,
          finishFailure: l,
        ),
        (_) => state.copyWith(finishStatus: BlocStatus.success),
      ),
    );
  }
}
