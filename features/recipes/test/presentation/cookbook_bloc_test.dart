import 'dart:async';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/events/app_event_bus.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes/domain/entities/saved_recipe_entity.dart';
import 'package:recipes/presentation/pages/cookbook/bloc/cookbook_bloc.dart';

import '../helpers/fixtures.dart';
import '../helpers/mocks.dart';

typedef _Result = Either<Failure, List<SavedRecipeEntity>>;

_Result _ok(List<SavedRecipeEntity> recipes) =>
    Right<Failure, List<SavedRecipeEntity>>(recipes);

_Result _err([Failure f = const ServerFailure()]) =>
    Left<Failure, List<SavedRecipeEntity>>(f);

void main() {
  late MockGetCookbookUseCase getCookbook;
  late MockWatchCookbookUseCase watchCookbook;
  late AppEventBus eventBus;
  late StreamController<_Result> watch;

  const Failure failure = ServerFailure();

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    getCookbook = MockGetCookbookUseCase();
    watchCookbook = MockWatchCookbookUseCase();
    eventBus = AppEventBus();
    watch = StreamController<_Result>.broadcast();
    when(() => watchCookbook(any())).thenAnswer((_) => watch.stream);
  });

  tearDown(() async {
    await watch.close();
    await eventBus.dispose();
  });

  CookbookBloc buildBloc() =>
      CookbookBloc(getCookbook, watchCookbook, eventBus);

  test('initial state is CookbookState() with initial status', () {
    when(
      () => getCookbook(any()),
    ).thenAnswer((_) async => _ok(const <SavedRecipeEntity>[]));
    final CookbookBloc bloc = buildBloc();
    expect(bloc.state, const CookbookState());
    expect(bloc.state.status, BlocStatus.initial);
    bloc.close();
  });

  test(
    'started with empty cache + failed sync emits loading then error',
    () async {
      when(() => getCookbook(any())).thenAnswer((_) async => _err(failure));

      final CookbookBloc bloc = buildBloc();
      final List<CookbookState> states = <CookbookState>[];
      final StreamSubscription<CookbookState> sub = bloc.stream.listen(
        states.add,
      );

      bloc.add(const CookbookEvent.started());
      await pumpEventQueue();

      expect(
        states.map((CookbookState s) => s.status),
        <BlocStatus>[BlocStatus.loading, BlocStatus.error],
      );
      expect(states.last.failure, failure);
      expect(states.last.recipes, isEmpty);

      await sub.cancel();
      await bloc.close();
    },
  );

  test('started with empty cache + empty sync ends in empty state', () async {
    when(() => getCookbook(any())).thenAnswer(
      (_) async => _ok(const <SavedRecipeEntity>[]),
    );

    final CookbookBloc bloc = buildBloc();
    final List<CookbookState> states = <CookbookState>[];
    final StreamSubscription<CookbookState> sub = bloc.stream.listen(
      states.add,
    );

    bloc.add(const CookbookEvent.started());
    await pumpEventQueue();

    expect(
      states.map((CookbookState s) => s.status),
      <BlocStatus>[BlocStatus.loading, BlocStatus.empty],
    );

    await sub.cancel();
    await bloc.close();
  });

  test('watch stream populates recipes and drives success', () async {
    final Completer<_Result> syncResult = Completer<_Result>();
    when(() => getCookbook(any())).thenAnswer((_) => syncResult.future);

    final CookbookBloc bloc = buildBloc();
    final List<CookbookState> states = <CookbookState>[];
    final StreamSubscription<CookbookState> sub = bloc.stream.listen(
      states.add,
    );

    bloc.add(const CookbookEvent.started());
    await pumpEventQueue();
    // After start: sync has emitted loading and is awaiting the backend.
    expect(states.single.status, BlocStatus.loading);

    // The watch stream delivers the cached recipes.
    watch.add(_ok(<SavedRecipeEntity>[savedEntity()]));
    await pumpEventQueue();

    // The backend sync then resolves (matching data → no further state change).
    syncResult.complete(_ok(<SavedRecipeEntity>[savedEntity()]));
    await pumpEventQueue();

    expect(states.last.status, BlocStatus.success);
    expect(states.last.recipes, <SavedRecipeEntity>[savedEntity()]);

    await sub.cancel();
    await bloc.close();
  });

  test('watch failure is swallowed: keeps state, no error surfaced', () async {
    when(() => getCookbook(any())).thenAnswer(
      (_) async => _ok(const <SavedRecipeEntity>[]),
    );

    final CookbookBloc bloc = buildBloc();
    final List<CookbookState> states = <CookbookState>[];
    final StreamSubscription<CookbookState> sub = bloc.stream.listen(
      states.add,
    );

    bloc.add(const CookbookEvent.started());
    await pumpEventQueue();

    // A cache error arrives on the watch stream — it must NOT flip to error.
    watch.add(_err(failure));
    await pumpEventQueue();
    expect(
      states.every((CookbookState s) => s.status != BlocStatus.error),
      isTrue,
    );

    // A later good emission still flows through.
    watch.add(_ok(<SavedRecipeEntity>[savedEntity()]));
    await pumpEventQueue();
    expect(states.last.status, BlocStatus.success);
    expect(states.last.recipes, <SavedRecipeEntity>[savedEntity()]);

    await sub.cancel();
    await bloc.close();
  });

  test('RecipeSaved event on the bus triggers a resync', () async {
    when(() => getCookbook(any())).thenAnswer(
      (_) async => _ok(<SavedRecipeEntity>[savedEntity()]),
    );

    final CookbookBloc bloc = buildBloc();
    bloc.add(const CookbookEvent.started());
    await pumpEventQueue();
    // Initial sync from start.
    verify(() => getCookbook(any())).called(1);

    eventBus.publish(const RecipeSaved());
    await pumpEventQueue();

    // The bus event drove a second sync.
    verify(() => getCookbook(any())).called(1);

    await bloc.close();
  });

  test('refreshed (pull-to-refresh) re-reads the cookbook', () async {
    when(() => getCookbook(any())).thenAnswer(
      (_) async => _ok(<SavedRecipeEntity>[savedEntity()]),
    );

    final CookbookBloc bloc = buildBloc();
    bloc.add(const CookbookEvent.started());
    await pumpEventQueue();
    verify(() => getCookbook(any())).called(1);

    bloc.add(const CookbookEvent.refreshed());
    await pumpEventQueue();
    verify(() => getCookbook(any())).called(1);

    await bloc.close();
  });

  test(
    'sync with non-empty recipes keeps success without a loading flash',
    () async {
      // Seed recipes via the watch stream first, then a refresh must not show a
      // loading state (recipes are already present).
      when(() => getCookbook(any())).thenAnswer(
        (_) async => _ok(<SavedRecipeEntity>[savedEntity()]),
      );

      final CookbookBloc bloc = buildBloc();
      bloc.add(const CookbookEvent.started());
      await pumpEventQueue();
      watch.add(_ok(<SavedRecipeEntity>[savedEntity()]));
      await pumpEventQueue();

      final List<CookbookState> states = <CookbookState>[];
      final StreamSubscription<CookbookState> sub = bloc.stream.listen(
        states.add,
      );

      bloc.add(const CookbookEvent.refreshed());
      await pumpEventQueue();

      expect(
        states.every((CookbookState s) => s.status != BlocStatus.loading),
        isTrue,
      );

      await sub.cancel();
      await bloc.close();
    },
  );
}
