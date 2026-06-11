import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/usecases/sign_out_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._signOut) : super(const ProfileState());

  final SignOutUseCase _signOut;

  Future<void> signOut() async {
    emit(
      state.copyWith(
        signOutStatus: BlocStatus.loading,
      ),
    );

    final Either<Failure, Unit> result = await _signOut(const NoParams());

    if (isClosed) return;

    emit(
      result.fold(
        (Failure l) => state.copyWith(
          signOutStatus: BlocStatus.error,
          signOutFailure: l,
        ),
        (_) => state.copyWith(
          signOutStatus: BlocStatus.success,
        ),
      ),
    );
  }
}
