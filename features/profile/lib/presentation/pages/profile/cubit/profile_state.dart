part of 'profile_cubit.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    ProfileEntity? profile,
    @Default(BlocStatus.initial) BlocStatus loadStatus,
    int? scanCount,
    @Default(BlocStatus.initial) BlocStatus dietaryStatus,
    Failure? dietaryFailure,
    @Default(BlocStatus.initial) BlocStatus signOutStatus,
    Failure? signOutFailure,
  }) = _ProfileState;

  const ProfileState._();

  /// The user's saved dietary preference, resolved to its enum (defaults to
  /// [DietaryPreference.none] when unset).
  DietaryPreference get dietaryPreference => DietaryPreference.fromValue(profile?.dietaryPreference);
}
