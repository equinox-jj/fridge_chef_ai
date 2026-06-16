import 'dart:async';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/events/app_event_bus.dart';
import 'package:core/router/args/recipe_generation_args.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes/data/models/recipe_model.dart';
import 'package:recipes/data/models/saved_recipe_model.dart';
import 'package:recipes/data/repositories/recipe_repository_impl.dart';
import 'package:recipes/domain/entities/recipe_entity.dart';
import 'package:recipes/domain/entities/saved_recipe_entity.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockRecipeRemoteDataSource remote;
  late MockRecipeLocalDataSource local;
  late MockConnectivityService connectivity;
  late AppEventBus eventBus;
  late RecipeRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(savedModel());
    registerFallbackValue(recipeModel());
    registerFallbackValue(<SavedRecipeModel>[]);
  });

  setUp(() {
    remote = MockRecipeRemoteDataSource();
    local = MockRecipeLocalDataSource();
    connectivity = MockConnectivityService();
    eventBus = AppEventBus();
    repository = RecipeRepositoryImpl(
      remoteDataSource: remote,
      localDataSource: local,
      connectivity: connectivity,
      eventBus: eventBus,
      logger: FakeLogger(),
    );
  });

  void goOnline() =>
      when(() => connectivity.isOnline).thenAnswer((_) async => true);
  void goOffline() =>
      when(() => connectivity.isOnline).thenAnswer((_) async => false);

  group('getCookbook', () {
    test(
      'online: refreshes the cache from the backend then serves the cache',
      () async {
        goOnline();
        when(
          () => remote.getSavedRecipes(),
        ).thenAnswer((_) async => <SavedRecipeModel>[savedModel()]);
        when(() => local.replaceCookbook(any())).thenAnswer((_) async {});
        when(
          () => local.getCookbook(),
        ).thenAnswer((_) async => <SavedRecipeModel>[savedModel()]);

        final Either<Failure, List<SavedRecipeEntity>> result = await repository
            .getCookbook();

        expect(
          result.getOrElse((_) => fail('expected Right')),
          <SavedRecipeEntity>[savedEntity()],
        );
        verify(() => remote.getSavedRecipes()).called(1);
        verify(
          () => local.replaceCookbook(<SavedRecipeModel>[savedModel()]),
        ).called(1);
        verify(() => local.getCookbook()).called(1);
      },
    );

    test('offline: skips the refresh and serves the cache only', () async {
      goOffline();
      when(
        () => local.getCookbook(),
      ).thenAnswer((_) async => <SavedRecipeModel>[savedModel()]);

      final Either<Failure, List<SavedRecipeEntity>> result = await repository
          .getCookbook();

      expect(result.isRight(), isTrue);
      verifyNever(() => remote.getSavedRecipes());
      verifyNever(() => local.replaceCookbook(any()));
      verify(() => local.getCookbook()).called(1);
    });

    test(
      'online: a failed backend refresh is swallowed; cache still served',
      () async {
        goOnline();
        when(() => remote.getSavedRecipes()).thenThrow(const ServerException());
        when(
          () => local.getCookbook(),
        ).thenAnswer((_) async => <SavedRecipeModel>[savedModel()]);

        final Either<Failure, List<SavedRecipeEntity>> result = await repository
            .getCookbook();

        expect(result.isRight(), isTrue);
        verifyNever(() => local.replaceCookbook(any()));
        verify(() => local.getCookbook()).called(1);
      },
    );

    test('maps a cache read failure to a Left CacheFailure', () async {
      goOffline();
      when(() => local.getCookbook()).thenThrow(const CacheException());

      final Either<Failure, List<SavedRecipeEntity>> result = await repository
          .getCookbook();

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<CacheFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('watchCookbook', () {
    test('maps cached models to entities wrapped in Right', () async {
      when(() => local.watchCookbook()).thenAnswer(
        (_) => Stream<List<SavedRecipeModel>>.value(
          <SavedRecipeModel>[savedModel()],
        ),
      );

      final Either<Failure, List<SavedRecipeEntity>> first = await repository
          .watchCookbook()
          .first;

      expect(
        first.getOrElse((_) => fail('expected Right')),
        <SavedRecipeEntity>[savedEntity()],
      );
    });

    test(
      'maps a cache stream error to a Left CacheFailure (stays open)',
      () async {
        when(() => local.watchCookbook()).thenAnswer(
          (_) => Stream<List<SavedRecipeModel>>.error(const CacheException()),
        );

        final Either<Failure, List<SavedRecipeEntity>> first = await repository
            .watchCookbook()
            .first;

        expect(first.isLeft(), isTrue);
        first.match(
          (Failure f) => expect(f, isA<CacheFailure>()),
          (_) => fail('expected Left'),
        );
      },
    );
  });

  group('getRecipeDetail', () {
    test(
      'online: fetches from backend and writes through to the cache',
      () async {
        goOnline();
        when(
          () => remote.getRecipeById(id: 'r1'),
        ).thenAnswer((_) async => recipeModel());
        when(
          () => local.cacheRecipeDetail(
            id: any(named: 'id'),
            recipe: any(named: 'recipe'),
          ),
        ).thenAnswer((_) async {});

        final Either<Failure, RecipeEntity> result = await repository
            .getRecipeDetail(id: 'r1');

        expect(result, Right<Failure, RecipeEntity>(recipeEntity()));
        verify(
          () => local.cacheRecipeDetail(
            id: 'r1',
            recipe: any(named: 'recipe'),
          ),
        ).called(1);
        verifyNever(() => local.getRecipeDetail(id: any(named: 'id')));
      },
    );

    test(
      'online: a cache write-through hiccup does not fail the fetch',
      () async {
        goOnline();
        when(
          () => remote.getRecipeById(id: 'r1'),
        ).thenAnswer((_) async => recipeModel());
        when(
          () => local.cacheRecipeDetail(
            id: any(named: 'id'),
            recipe: any(named: 'recipe'),
          ),
        ).thenThrow(const CacheException());

        final Either<Failure, RecipeEntity> result = await repository
            .getRecipeDetail(id: 'r1');

        expect(result, Right<Failure, RecipeEntity>(recipeEntity()));
      },
    );

    test('online: a failed backend fetch falls back to the cache', () async {
      goOnline();
      when(
        () => remote.getRecipeById(id: 'r1'),
      ).thenThrow(const ServerException());
      when(
        () => local.getRecipeDetail(id: 'r1'),
      ).thenAnswer((_) async => recipeModel());

      final Either<Failure, RecipeEntity> result = await repository
          .getRecipeDetail(id: 'r1');

      expect(result, Right<Failure, RecipeEntity>(recipeEntity()));
      verify(() => local.getRecipeDetail(id: 'r1')).called(1);
    });

    test('offline: serves the cached detail', () async {
      goOffline();
      when(
        () => local.getRecipeDetail(id: 'r1'),
      ).thenAnswer((_) async => recipeModel());

      final Either<Failure, RecipeEntity> result = await repository
          .getRecipeDetail(id: 'r1');

      expect(result, Right<Failure, RecipeEntity>(recipeEntity()));
      verifyNever(() => remote.getRecipeById(id: any(named: 'id')));
    });

    test('offline with nothing cached: Left CacheFailure', () async {
      goOffline();
      when(() => local.getRecipeDetail(id: 'r1')).thenAnswer((_) async => null);

      final Either<Failure, RecipeEntity> result = await repository
          .getRecipeDetail(id: 'r1');

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<CacheFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('generateRecipes', () {
    final List<RecipeSeedIngredient> ingredients = <RecipeSeedIngredient>[
      const RecipeSeedIngredient(name: 'egg', quantity: '2', unit: 'pcs'),
    ];

    test(
      'renders prompt lines and maps generated recipes to entities',
      () async {
        when(
          () => remote.generateRecipes(
            ingredientLines: any(named: 'ingredientLines'),
            mood: any(named: 'mood'),
            dietaryPreference: any(named: 'dietaryPreference'),
          ),
        ).thenAnswer((_) async => <RecipeModel>[recipeModel()]);

        final Either<Failure, List<RecipeEntity>> result = await repository
            .generateRecipes(
              ingredients: ingredients,
              mood: 'cozy',
              dietaryPreference: 'none',
            );

        expect(
          result.getOrElse((_) => fail('expected Right')),
          <RecipeEntity>[recipeEntity()],
        );
        // The seed ingredient is flattened into a single prompt line.
        verify(
          () => remote.generateRecipes(
            ingredientLines: <String>['2 pcs egg'],
            mood: 'cozy',
            dietaryPreference: 'none',
          ),
        ).called(1);
      },
    );

    test('maps a thrown exception to a Left Failure', () async {
      when(
        () => remote.generateRecipes(
          ingredientLines: any(named: 'ingredientLines'),
          mood: any(named: 'mood'),
          dietaryPreference: any(named: 'dietaryPreference'),
        ),
      ).thenThrow(const ServerException());

      final Either<Failure, List<RecipeEntity>> result = await repository
          .generateRecipes(
            ingredients: ingredients,
            mood: 'cozy',
            dietaryPreference: 'none',
          );

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<ServerFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('getDietaryPreference', () {
    test('returns the remote value', () async {
      when(
        () => remote.getDietaryPreference(),
      ).thenAnswer((_) async => 'vegan');

      final Either<Failure, String> result = await repository
          .getDietaryPreference();

      expect(result, const Right<Failure, String>('vegan'));
    });

    test('maps a thrown exception to a Left Failure', () async {
      when(
        () => remote.getDietaryPreference(),
      ).thenThrow(const NetworkException());

      final Either<Failure, String> result = await repository
          .getDietaryPreference();

      expect(result.isLeft(), isTrue);
      result.match(
        (Failure f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  group('saveRecipe', () {
    test(
      'persists, write-through caches, publishes RecipeSaved, returns unit',
      () async {
        when(
          () => remote.saveRecipe(
            recipe: any(named: 'recipe'),
            rating: any(named: 'rating'),
            note: any(named: 'note'),
            scanId: any(named: 'scanId'),
          ),
        ).thenAnswer((_) async => savedModel());
        when(() => local.upsert(any())).thenAnswer((_) async {});

        final List<AppEvent> events = <AppEvent>[];
        final StreamSubscription<AppEvent> sub = eventBus.stream.listen(
          events.add,
        );

        final Either<Failure, Unit> result = await repository.saveRecipe(
          recipe: recipeEntity(),
          rating: 5,
          note: 'yum',
          scanId: 'scan1',
        );

        await pumpEventQueue();
        expect(result, const Right<Failure, Unit>(unit));
        verify(() => local.upsert(savedModel())).called(1);
        expect(events, <Matcher>[isA<RecipeSaved>()]);

        await sub.cancel();
      },
    );

    test('a cache write-through failure does not fail the save', () async {
      when(
        () => remote.saveRecipe(
          recipe: any(named: 'recipe'),
          rating: any(named: 'rating'),
          note: any(named: 'note'),
          scanId: any(named: 'scanId'),
        ),
      ).thenAnswer((_) async => savedModel());
      when(() => local.upsert(any())).thenThrow(const CacheException());

      final List<AppEvent> events = <AppEvent>[];
      final StreamSubscription<AppEvent> sub = eventBus.stream.listen(
        events.add,
      );

      final Either<Failure, Unit> result = await repository.saveRecipe(
        recipe: recipeEntity(),
        rating: 5,
      );

      await pumpEventQueue();
      expect(result, const Right<Failure, Unit>(unit));
      expect(events, <Matcher>[isA<RecipeSaved>()]);

      await sub.cancel();
    });

    test(
      'a remote save failure is mapped to Left and nothing is published',
      () async {
        when(
          () => remote.saveRecipe(
            recipe: any(named: 'recipe'),
            rating: any(named: 'rating'),
            note: any(named: 'note'),
            scanId: any(named: 'scanId'),
          ),
        ).thenThrow(const ServerException());

        final List<AppEvent> events = <AppEvent>[];
        final StreamSubscription<AppEvent> sub = eventBus.stream.listen(
          events.add,
        );

        final Either<Failure, Unit> result = await repository.saveRecipe(
          recipe: recipeEntity(),
          rating: 5,
        );

        await pumpEventQueue();
        expect(result.isLeft(), isTrue);
        verifyNever(() => local.upsert(any()));
        expect(events, isEmpty);

        await sub.cancel();
      },
    );
  });
}
