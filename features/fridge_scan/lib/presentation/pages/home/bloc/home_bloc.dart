import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/scan_result_entity.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../domain/usecases/get_user_profile_usecase.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getUserProfile) : super(HomeState()) {
    on<_Started>(_onStarted);
  }

  final GetUserProfileUseCase _getUserProfile;

  Future<void> _onStarted(_Started event, Emitter<HomeState> emit) async {
    final Either<Failure, UserProfile?> result = await _getUserProfile(const NoParams());

    result.fold(
      // On failure we keep the greeting generic rather than surfacing an error.
      (Failure _) {},
      (UserProfile? profile) => emit(state.copyWith(userProfile: profile)),
    );
  }
}
