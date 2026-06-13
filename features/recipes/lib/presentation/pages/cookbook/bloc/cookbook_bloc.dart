import 'dart:async';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/saved_recipe_entity.dart';
import '../../../../domain/usecases/get_cookbook_usecase.dart';

part 'cookbook_bloc.freezed.dart';
part 'cookbook_event.dart';
part 'cookbook_state.dart';

/// Drives the cookbook tab: loads the user's saved recipes (offline-first) and
/// tracks online/offline so the page can show the offline banner and gate
/// scanning.
///
/// Loading is delegated to [GetCookbookUseCase], which serves the on-device
/// cache and refreshes it from the backend when online — so this bloc stays
/// agnostic about *where* the recipes come from. It does, however, watch
/// [ConnectivityService]: regaining a connection triggers a reload so a
/// previously offline cookbook picks up anything saved on another device.
class CookbookBloc extends Bloc<CookbookEvent, CookbookState> {
  CookbookBloc(this._getCookbook, this._connectivity) : super(const CookbookState()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
    on<_ConnectivityChanged>(_onConnectivityChanged);
  }

  final GetCookbookUseCase _getCookbook;
  final ConnectivityService _connectivity;

  StreamSubscription<bool>? _connectivitySub;

  Future<void> _onStarted(_Started event, Emitter<CookbookState> emit) async {
    emit(state.copyWith(isOffline: !await _connectivity.isOnline));
    _connectivitySub ??= _connectivity.onStatusChanged.listen(
      (bool isOnline) => add(CookbookEvent.connectivityChanged(isOnline: isOnline)),
    );
    await _load(emit);
  }

  Future<void> _onRefreshed(_Refreshed event, Emitter<CookbookState> emit) => _load(emit);

  Future<void> _onConnectivityChanged(
    _ConnectivityChanged event,
    Emitter<CookbookState> emit,
  ) async {
    final bool wasOffline = state.isOffline;
    emit(state.copyWith(isOffline: !event.isOnline));
    // Coming back online: refresh so the cache catches up with the backend.
    if (wasOffline && event.isOnline) {
      await _load(emit);
    }
  }

  /// Loads the cookbook, keeping any already-shown recipes visible while the
  /// (usually instant) cache read runs.
  Future<void> _load(Emitter<CookbookState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading, failure: null));

    final Either<Failure, List<SavedRecipeEntity>> result = await _getCookbook(const NoParams());

    emit(
      result.fold(
        (Failure failure) => state.copyWith(status: BlocStatus.error, failure: failure),
        (List<SavedRecipeEntity> recipes) => state.copyWith(
          status: recipes.isEmpty ? BlocStatus.empty : BlocStatus.success,
          recipes: recipes,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _connectivitySub?.cancel();
    return super.close();
  }
}
