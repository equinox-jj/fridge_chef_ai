import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes/data/datasources/local/recipe_local_data_source_impl.dart';
import 'package:recipes/data/models/recipe_model.dart';
import 'package:recipes/data/models/saved_recipe_model.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

void main() {
  late AppDatabase database;
  late RecipeLocalDataSourceImpl dataSource;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = RecipeLocalDataSourceImpl(
      database: database,
      logger: FakeLogger(),
    );
  });

  tearDown(() => database.close());

  group('cookbook cache', () {
    test('getCookbook returns an empty list when nothing is cached', () async {
      expect(await dataSource.getCookbook(), isEmpty);
    });

    test('replaceCookbook then getCookbook round-trips a row', () async {
      await dataSource.replaceCookbook(<SavedRecipeModel>[savedModel()]);

      final List<SavedRecipeModel> result = await dataSource.getCookbook();

      expect(result, hasLength(1));
      final SavedRecipeModel row = result.single;
      expect(row.id, 'r1');
      expect(row.title, 'Pasta');
      expect(row.cookTimeMinutes, 20);
      expect(row.mood, 'cozy');
      expect(row.rating, 4);
      expect(row.savedAt.isAtSameMomentAs(tSavedAt), isTrue);
    });

    test('getCookbook orders newest first by savedAt', () async {
      final SavedRecipeModel older = savedModel(
        id: 'old',
        savedAt: DateTime.utc(2026, 1, 1),
      );
      final SavedRecipeModel newer = savedModel(
        id: 'new',
        savedAt: DateTime.utc(2026, 2, 1),
      );
      await dataSource.replaceCookbook(<SavedRecipeModel>[older, newer]);

      final List<SavedRecipeModel> result = await dataSource.getCookbook();

      expect(result.map((SavedRecipeModel r) => r.id), <String>['new', 'old']);
    });

    test('replaceCookbook fully replaces the previous cache', () async {
      await dataSource.replaceCookbook(<SavedRecipeModel>[savedModel(id: 'a')]);
      await dataSource.replaceCookbook(<SavedRecipeModel>[savedModel(id: 'b')]);

      final List<SavedRecipeModel> result = await dataSource.getCookbook();

      expect(result.map((SavedRecipeModel r) => r.id), <String>['b']);
    });

    test('upsert inserts a new entry', () async {
      await dataSource.upsert(savedModel(id: 'x', title: 'New'));

      final List<SavedRecipeModel> result = await dataSource.getCookbook();
      expect(result.single.id, 'x');
      expect(result.single.title, 'New');
    });

    test('upsert updates an existing entry on id conflict', () async {
      await dataSource.upsert(savedModel(id: 'x', title: 'Before', rating: 1));
      await dataSource.upsert(savedModel(id: 'x', title: 'After', rating: 5));

      final List<SavedRecipeModel> result = await dataSource.getCookbook();
      expect(result, hasLength(1));
      expect(result.single.title, 'After');
      expect(result.single.rating, 5);
    });

    test(
      'watchCookbook emits the current cache and re-emits on change',
      () async {
        final Stream<List<SavedRecipeModel>> stream = dataSource
            .watchCookbook();
        final Future<List<List<SavedRecipeModel>>> firstTwo = stream
            .take(2)
            .toList();

        // Let the initial (empty) emission settle, then mutate.
        await pumpEventQueue();
        await dataSource.upsert(savedModel(id: 'x'));

        final List<List<SavedRecipeModel>> emissions = await firstTwo;
        expect(emissions.first, isEmpty);
        expect(emissions[1].map((SavedRecipeModel r) => r.id), <String>['x']);
      },
    );
  });

  group('recipe detail cache', () {
    test('getRecipeDetail returns null on a cache miss', () async {
      expect(await dataSource.getRecipeDetail(id: 'missing'), isNull);
    });

    test(
      'cacheRecipeDetail then getRecipeDetail round-trips the detail',
      () async {
        await dataSource.cacheRecipeDetail(id: 'r1', recipe: recipeModel());

        final RecipeModel? result = await dataSource.getRecipeDetail(id: 'r1');

        // toJson writes `mood`, so the detail cache round-trips it back.
        expect(result, recipeModel());
        expect(result?.mood, 'cozy');
      },
    );

    test('cacheRecipeDetail overwrites a previously cached detail', () async {
      await dataSource.cacheRecipeDetail(
        id: 'r1',
        recipe: recipeModel(title: 'First'),
      );
      await dataSource.cacheRecipeDetail(
        id: 'r1',
        recipe: recipeModel(title: 'Second'),
      );

      final RecipeModel? result = await dataSource.getRecipeDetail(id: 'r1');
      expect(result?.title, 'Second');
    });
  });

  group('cacheGuard error mapping', () {
    test('a corrupt cached payload surfaces as a CacheException', () async {
      // Write an undecodable payload directly, bypassing cacheRecipeDetail, so
      // getRecipeDetail's jsonDecode throws inside the guard.
      await database
          .into(database.recipeDetailRows)
          .insert(
            RecipeDetailRowsCompanion.insert(
              id: 'bad',
              payload: 'not-json',
              cachedAt: DateTime.now(),
            ),
          );

      expect(
        () => dataSource.getRecipeDetail(id: 'bad'),
        throwsA(isA<CacheException>()),
      );
    });
  });
}
