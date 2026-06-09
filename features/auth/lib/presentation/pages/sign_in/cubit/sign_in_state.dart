import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/user_entity.dart';

part 'sign_in_state.freezed.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = SignInInitial;
  const factory SignInState.loading() = SignInLoading;
  const factory SignInState.success(UserEntity user) = SignInSuccess;
  const factory SignInState.error(Failure failure) = SignInError;
}
