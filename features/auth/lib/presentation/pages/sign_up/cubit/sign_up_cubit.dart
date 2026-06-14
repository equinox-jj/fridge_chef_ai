import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUp) : super(const SignUpState());

  final SignUpUseCase _signUp;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        signUpStatus: BlocStatus.loading,
      ),
    );

    final Either<Failure, UserEntity> result = await _signUp(
      SignUpParams(
        name: name,
        email: email,
        password: password,
      ),
    );

    if (isClosed) return;

    emit(
      result.fold(
        (Failure l) => state.copyWith(
          signUpStatus: BlocStatus.error,
          signUpFailure: l,
        ),
        (UserEntity r) => state.copyWith(
          signUpStatus: BlocStatus.success,
          signUpResponse: r,
        ),
      ),
    );
  }
}
