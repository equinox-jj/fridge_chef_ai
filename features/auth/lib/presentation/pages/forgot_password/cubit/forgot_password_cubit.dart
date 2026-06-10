import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._forgotPassword) : super(const ForgotPasswordState.initial());

  final ForgotPasswordUseCase _forgotPassword;

  Future<void> forgotPassword({required String email}) async {
    emit(const ForgotPasswordState.loading());
    final Either<Failure, Unit> result = await _forgotPassword(
      ForgotPasswordParams(email: email),
    );
    // Guard against the page being disposed mid-request (closing this cubit).
    if (isClosed) return;
    emit(
      result.fold(
        (Failure failure) => ForgotPasswordState.error(failure),
        (_) => const ForgotPasswordState.success(),
      ),
    );
  }
}
