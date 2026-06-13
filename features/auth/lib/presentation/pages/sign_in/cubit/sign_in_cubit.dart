import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/sign_in_usecase.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._signIn) : super(const SignInState());

  final SignInUseCase _signIn;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        signInStatus: BlocStatus.loading,
      ),
    );

    final Either<Failure, UserEntity> result = await _signIn(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    if (isClosed) return;

    emit(
      result.fold(
        (Failure l) => state.copyWith(
          signInStatus: BlocStatus.error,
          signInFailure: l,
        ),
        (UserEntity r) => state.copyWith(
          signInStatus: BlocStatus.success,
          signInResponse: r,
        ),
      ),
    );
  }

}
