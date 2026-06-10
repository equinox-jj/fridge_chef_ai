import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/user_entity.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(BlocStatus.initial) BlocStatus signUpStatus,
    Failure? signUpFailure,
    UserEntity? signUpResponse,
    @Default(true) bool obscurePassword,
  }) = _SignUpState;
}
