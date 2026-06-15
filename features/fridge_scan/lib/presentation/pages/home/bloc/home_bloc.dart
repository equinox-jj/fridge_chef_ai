import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/scan_result_entity.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../domain/usecases/get_recent_scans_usecase.dart';
import '../../../../domain/usecases/get_user_profile_usecase.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getUserProfile, this._getRecentScans)
    : super(const HomeState()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
  }

  final GetUserProfileUseCase _getUserProfile;
  final GetRecentScansUseCase _getRecentScans;

  Future<void> _onStarted(_Started event, Emitter<HomeState> emit) async {
    await Future.wait(<Future<void>>[
      _watchProfile(emit),
      _loadRecentScans(emit),
    ]);
  }

  /// Re-fetches recent scans only — used when returning to the home tab after a
  /// scan so a brand-new result shows up without a full reload.
  Future<void> _onRefreshed(_Refreshed event, Emitter<HomeState> emit) {
    return _loadRecentScans(emit);
  }

  /// Subscribes to the cached profile and re-emits state on every change. The
  /// stream is long-lived (it never completes), so this keeps the subscription
  /// alive for the bloc's lifetime; bloc cancels it automatically on close.
  Future<void> _watchProfile(Emitter<HomeState> emit) {
    return emit.forEach<Either<Failure, UserProfile?>>(
      _getUserProfile(const NoParams()),
      onData: (Either<Failure, UserProfile?> result) => result.fold(
        // On failure we keep the greeting generic rather than surfacing an error.
        (Failure _) => state,
        (UserProfile? profile) => state.copyWith(userProfile: profile),
      ),
    );
  }

  Future<void> _loadRecentScans(Emitter<HomeState> emit) async {
    emit(state.copyWith(recentScansStatus: BlocStatus.loading));

    final Either<Failure, List<ScanResultEntity>> result =
        await _getRecentScans(const NoParams());
    emit(
      result.fold(
        (Failure _) => state.copyWith(
          recentScansStatus: BlocStatus.error,
        ),
        (List<ScanResultEntity> scans) => state.copyWith(
          recentScans: scans,
          recentScansStatus: scans.isEmpty
              ? BlocStatus.empty
              : BlocStatus.success,
        ),
      ),
    );
  }
}
