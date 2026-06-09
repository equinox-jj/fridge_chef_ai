import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/user_entity.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = SignUpInitial;
  const factory SignUpState.loading() = SignUpLoading;
  const factory SignUpState.success(UserEntity user) = SignUpSuccess;
  const factory SignUpState.error(Failure failure) = SignUpError;
}
