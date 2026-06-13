import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

/// Where the splash gate hands the user off once it has decided.
enum SplashDestination {
  /// First run — show the onboarding flow.
  onboarding,

  /// Onboarding already done — go to the app, letting the auth guard send the
  /// user to sign-in when there is no session.
  home,
}

@freezed
abstract class SplashState with _$SplashState {
  /// [destination] is `null` until the gate resolves where to route.
  const factory SplashState({
    SplashDestination? destination,
  }) = _SplashState;
}
