import 'dart:async';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/events/app_event_bus.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/scan_result_entity.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../domain/usecases/get_user_profile_usecase.dart';
import '../../../../domain/usecases/watch_recent_scans_usecase.dart';
import '../../../../domain/usecases/get_recent_scans_usecase.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

/// Drives the home tab. The profile and recent-scans lists are both reactive:
/// they come from long-lived watch streams (the cache is the source of truth),
/// so any write surfaces here regardless of navigation. A backend resync is
/// triggered on start, on pull-to-refresh, and whenever a [ScanCreated] event
/// is announced on the [AppEventBus]; its result flows back through the recent-
/// scans watch stream.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._getUserProfile,
    this._watchRecentScans,
    this._syncRecentScans,
    this._eventBus,
  ) : super(const HomeState()) {
    on<_Started>(_onStarted);
    on<_Synced>(_onSynced);
  }

  final GetUserProfileUseCase _getUserProfile;
  final WatchRecentScansUseCase _watchRecentScans;
  final GetRecentScansUseCase _syncRecentScans;
  final AppEventBus _eventBus;

  StreamSubscription<AppEvent>? _eventSub;

  Future<void> _onStarted(_Started event, Emitter<HomeState> emit) async {
    // Resync whenever a new scan is announced, even from another tab.
    _eventSub ??= _eventBus.stream.listen((AppEvent appEvent) {
      if (appEvent is ScanCreated) {
        add(const HomeEvent.synced());
      }
    });

    // Kick the initial backend sync; processed concurrently with the watches
    // below (different handler), exactly as the prior _Refreshed event was.
    add(const HomeEvent.synced());

    // Both streams are long-lived and never complete, keeping the subscriptions
    // alive for the bloc's lifetime; bloc cancels them on close.
    await Future.wait<void>(<Future<void>>[
      _watchProfile(emit),
      _watchScans(emit),
    ]);
  }

  /// Triggers a backend resync (replacing the cache). The recent-scans watch
  /// stream delivers the data; this only manages the [isSyncing] flag and the
  /// loading/error status. Network failures are swallowed in the repository, so
  /// the cache still serves what it has.
  Future<void> _onSynced(_Synced event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        isSyncing: true,
        // Only show the skeleton when there's nothing to show yet; a background
        // resync (e.g. after a new scan already in the list) must not hide it.
        recentScansStatus: state.recentScans.isEmpty
            ? BlocStatus.loading
            : state.recentScansStatus,
      ),
    );

    final Either<Failure, List<ScanResultEntity>> result =
        await _syncRecentScans(const NoParams());

    emit(
      state.copyWith(
        isSyncing: false,
        recentScansStatus: result.fold(
          (Failure _) =>
              state.recentScans.isEmpty ? BlocStatus.error : BlocStatus.success,
          (List<ScanResultEntity> scans) =>
              scans.isEmpty ? BlocStatus.empty : BlocStatus.success,
        ),
      ),
    );
  }

  /// Subscribes to the cached profile and re-emits on every change.
  Future<void> _watchProfile(Emitter<HomeState> emit) {
    return emit.forEach<Either<Failure, UserProfile?>>(
      _getUserProfile(const NoParams()),
      onData: (Either<Failure, UserProfile?> result) => result.fold(
        (Failure _) => state,
        (UserProfile? profile) => state.copyWith(userProfile: profile),
      ),
    );
  }

  /// Subscribes to the cached recent scans and re-emits on every change. Owns
  /// the [recentScans] list; status is owned by [_onSynced] except the natural
  /// empty/success transition once data exists.
  Future<void> _watchScans(Emitter<HomeState> emit) {
    return emit.forEach<Either<Failure, List<ScanResultEntity>>>(
      _watchRecentScans(const NoParams()),
      onData: (Either<Failure, List<ScanResultEntity>> result) => result.fold(
        // Cache errors surface via the sync path; keep current state here.
        (Failure _) => state,
        (List<ScanResultEntity> scans) => state.copyWith(
          recentScans: scans,
          recentScansStatus: scans.isNotEmpty
              ? BlocStatus.success
              : (state.isSyncing ? BlocStatus.loading : BlocStatus.empty),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _eventSub?.cancel();
    return super.close();
  }
}
