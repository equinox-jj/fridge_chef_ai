import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(BlocStatus.initial) BlocStatus forgotPasswordStatus,
    Failure? forgotPasswordFailure,
    @Default(0) int resendCountdown,
  }) = _ForgotPasswordState;
}
