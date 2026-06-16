import 'dart:async';

import 'package:core/blocs/connectivity_bloc.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/events/app_event_bus.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/saved_recipe_entity.dart';
import '../../../../domain/usecases/get_cookbook_usecase.dart';
import '../../../../domain/usecases/watch_cookbook_usecase.dart';

part 'cookbook_bloc.freezed.dart';
part 'cookbook_event.dart';
part 'cookbook_state.dart';

/// Drives the cookbook tab. The saved-recipes list is reactive: it comes from a
/// long-lived watch stream over the on-device cache (the source of truth), so a
/// recipe saved anywhere shows up here regardless of navigation. A backend
/// resync is triggered on start, on reconnect, on pull-to-refresh, and whenever
/// a [RecipeSaved] event is announced on the [AppEventBus]; its result flows
/// back through the watch stream.
///
/// Offline display (banner, disabled scan) is read straight from
/// [ConnectivityBloc] by the page; this bloc only reacts to reconnects to
/// refresh data.
class CookbookBloc extends Bloc<CookbookEvent, CookbookState> {
  CookbookBloc(
    this._getCookbook,
    this._watchCookbook,
    this._eventBus,
  ) : super(const CookbookState()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
  }

  final GetCookbookUseCase _getCookbook;
  final WatchCookbookUseCase _watchCookbook;
  final AppEventBus _eventBus;

  StreamSubscription<AppEvent>? _eventSub;

  Future<void> _onStarted(
    _Started event,
    Emitter<CookbookState> emit,
  ) async {
    // Resync whenever a recipe is saved, even from another tab.
    _eventSub ??= _eventBus.stream.listen((AppEvent appEvent) {
      if (appEvent is RecipeSaved) {
        add(const CookbookEvent.refreshed());
      }
    });

    // Kick the initial backend sync; processed concurrently with the watch.
    add(const CookbookEvent.refreshed());

    // Long-lived: keeps the cookbook list live for the bloc's lifetime.
    await _watchRecipes(emit);
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<CookbookState> emit,
  ) => _sync(emit);

  /// Subscribes to the cached cookbook and re-emits on every change. Owns the
  /// [recipes] list; status is owned by [_sync] except the natural
  /// empty/success transition once data exists.
  Future<void> _watchRecipes(Emitter<CookbookState> emit) {
    return emit.forEach<Either<Failure, List<SavedRecipeEntity>>>(
      _watchCookbook(const NoParams()),
      onData: (Either<Failure, List<SavedRecipeEntity>> result) => result.fold(
        // Cache errors surface via the sync path; keep current state here.
        (Failure _) => state,
        (List<SavedRecipeEntity> recipes) => state.copyWith(
          recipes: recipes,
          status: recipes.isNotEmpty
              ? BlocStatus.success
              : (state.status == BlocStatus.loading
                    ? BlocStatus.loading
                    : BlocStatus.empty),
        ),
      ),
    );
  }

  /// Triggers a backend resync (replacing the cache). The watch stream delivers
  /// the data; this manages the loading/error status. Network failures are
  /// swallowed in the repository, so the cache still serves what it has.
  Future<void> _sync(Emitter<CookbookState> emit) async {
    emit(
      state.copyWith(
        status: state.recipes.isEmpty ? BlocStatus.loading : state.status,
        failure: null,
      ),
    );

    final Either<Failure, List<SavedRecipeEntity>> result = await _getCookbook(
      const NoParams(),
    );

    emit(
      result.fold(
        (Failure failure) => state.recipes.isEmpty
            ? state.copyWith(status: BlocStatus.error, failure: failure)
            : state.copyWith(status: BlocStatus.success),
        (List<SavedRecipeEntity> recipes) => state.copyWith(
          status: recipes.isEmpty ? BlocStatus.empty : BlocStatus.success,
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
