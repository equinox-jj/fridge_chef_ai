import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    /// The page currently in view, mirrored from the [PageView] so the dots and
    /// the primary button stay in sync.
    @Default(0) int pageIndex,

    /// The dietary preference chosen on the setup page (defaults to "no
    /// restriction" until the user picks one).
    @Default(DietaryPreference.none) DietaryPreference dietaryPreference,

    /// Tracks persisting the completion flag when the user finishes.
    @Default(BlocStatus.initial) BlocStatus finishStatus,
    Failure? finishFailure,
  }) = _OnboardingState;
}
