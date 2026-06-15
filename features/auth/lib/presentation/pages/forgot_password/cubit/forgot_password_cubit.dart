import 'dart:async';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._forgotPassword)
    : super(const ForgotPasswordState());

  final ForgotPasswordUseCase _forgotPassword;

  /// Seconds a user must wait before requesting another code.
  static const int _resendCooldown = 60;

  Timer? _timer;

  Future<void> forgotPassword({required String email}) async {
    // Cooldown still running — ignore (the UI also disables the button).
    if (state.resendCountdown > 0) return;

    emit(state.copyWith(forgotPasswordStatus: BlocStatus.loading));

    final Either<Failure, Unit> result = await _forgotPassword(
      ForgotPasswordParams(email: email),
    );

    if (isClosed) return;

    result.fold(
      (Failure l) => emit(
        state.copyWith(
          forgotPasswordStatus: BlocStatus.error,
          forgotPasswordFailure: l,
        ),
      ),
      (_) {
        emit(
          state.copyWith(
            forgotPasswordStatus: BlocStatus.success,
            email: email,
          ),
        );
        _startResendCooldown();
      },
    );
  }

  /// Starts the 60-second countdown that gates resending the code.
  void _startResendCooldown() {
    _timer?.cancel();
    emit(state.copyWith(resendCountdown: _resendCooldown));

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      final int next = state.resendCountdown - 1;
      emit(state.copyWith(resendCountdown: next));
      if (next <= 0) timer.cancel();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
