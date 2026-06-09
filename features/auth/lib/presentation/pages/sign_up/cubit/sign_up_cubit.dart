import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUp) : super(const SignUpState.initial());

  final SignUpUseCase _signUp;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const SignUpState.loading());
    final Either<Failure, UserEntity> result = await _signUp(
      SignUpParams(name: name, email: email, password: password),
    );
    emit(
      result.fold(
        (Failure failure) => SignUpState.error(failure),
        (UserEntity user) => SignUpState.success(user),
      ),
    );
  }
}
