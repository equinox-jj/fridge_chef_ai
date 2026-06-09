import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
sealed class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = ForgotPasswordInitial;
  const factory ForgotPasswordState.loading() = ForgotPasswordLoading;
  const factory ForgotPasswordState.success() = ForgotPasswordSuccess;
  const factory ForgotPasswordState.error(Failure failure) = ForgotPasswordError;
}
