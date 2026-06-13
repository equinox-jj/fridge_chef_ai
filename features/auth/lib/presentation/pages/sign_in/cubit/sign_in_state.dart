import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/user_entity.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default(BlocStatus.initial) BlocStatus signInStatus,
    Failure? signInFailure,
    UserEntity? signInResponse,
  }) = _SignInState;
}
