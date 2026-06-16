import 'dart:async';
import 'dart:convert';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes/data/datasources/remote/recipe_remote_data_source_impl.dart';
import 'package:recipes/data/models/recipe_model.dart';
import 'package:recipes/data/models/saved_recipe_model.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

typedef PMap = Map<String, dynamic>;
typedef PList = List<Map<String, dynamic>>;

/// A postgrest builder stand-in that is awaitable. PostgrestFilterBuilder is a
/// subtype of PostgrestTransformBuilder and of Future, so this single fake can
/// be returned wherever the chain expects either, and `await` resolves it via
/// the overridden [then].
class _FakeBuilder<T> extends Fake implements PostgrestFilterBuilder<T> {
  _FakeBuilder.value(T value) : _value = value, _error = null;
  _FakeBuilder.error(Object error) : _value = null, _error = error;

  final T? _value;
  final Object? _error;

  @override
  Future<U> then<U>(
    FutureOr<U> Function(T value) onValue, {
    Function? onError,
  }) {
    final Future<T> base = _error != null
        ? Future<T>.error(_error)
        : Future<T>.value(_value as T);
    return base.then(onValue, onError: onError);
  }
}

void main() {
  late MockSupabaseClient client;
  late MockGoTrueClient auth;
  late MockUser user;
  late SupabaseService service;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    client = MockSupabaseClient();
    auth = MockGoTrueClient();
    user = MockUser();
    service = SupabaseService(client, FakeLogger());

    when(() => client.auth).thenAnswer((_) => auth);
    when(() => auth.currentUser).thenAnswer((_) => user);
    when(() => user.id).thenAnswer((_) => 'uid');
  });

  RecipeRemoteDataSourceImpl buildDataSource({
    RecipeContentGenerator? generator,
  }) {
    return RecipeRemoteDataSourceImpl(
      supabaseService: service,
      logger: FakeLogger(),
      contentGenerator: generator,
    );
  }

  void signOut() => when(() => auth.currentUser).thenAnswer((_) => null);

  group('getDietaryPreference', () {
    void stubRow(PMap? row) {
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> filter =
          MockPostgrestFilterBuilder<PList>();
      when(() => client.from('users')).thenAnswer((_) => qb);
      when(() => qb.select(any())).thenAnswer((_) => filter);
      when(() => filter.eq('id', 'uid')).thenAnswer((_) => filter);
      when(
        () => filter.maybeSingle(),
      ).thenAnswer((_) => _FakeBuilder<PMap?>.value(row));
    }

    test('returns the stored preference when present', () async {
      stubRow(<String, dynamic>{'dietary_preference': 'vegan'});
      expect(await buildDataSource().getDietaryPreference(), 'vegan');
    });

    test('falls back to the default diet when null', () async {
      stubRow(<String, dynamic>{'dietary_preference': null});
      expect(await buildDataSource().getDietaryPreference(), 'none');
    });

    test('falls back to the default diet when the row is missing', () async {
      stubRow(null);
      expect(await buildDataSource().getDietaryPreference(), 'none');
    });

    test('falls back to the default diet when empty', () async {
      stubRow(<String, dynamic>{'dietary_preference': ''});
      expect(await buildDataSource().getDietaryPreference(), 'none');
    });

    test('throws InvalidCredentialsException when signed out', () {
      signOut();
      // Stub the chain head so the only thing that throws is _requireUserId,
      // evaluated as the argument to .eq().
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> filter =
          MockPostgrestFilterBuilder<PList>();
      when(() => client.from('users')).thenAnswer((_) => qb);
      when(() => qb.select(any())).thenAnswer((_) => filter);

      expect(
        () => buildDataSource().getDietaryPreference(),
        throwsA(isA<InvalidCredentialsException>()),
      );
    });
  });

  group('getSavedRecipes', () {
    void stubRows(PList rows) {
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> filter =
          MockPostgrestFilterBuilder<PList>();
      when(() => client.from('saved_recipes')).thenAnswer((_) => qb);
      when(() => qb.select(any())).thenAnswer((_) => filter);
      when(() => filter.eq('user_id', 'uid')).thenAnswer((_) => filter);
      when(
        () => filter.order('saved_at', ascending: false),
      ).thenAnswer((_) => _FakeBuilder<PList>.value(rows));
    }

    test('maps join rows to models', () async {
      stubRows(<PMap>[savedRecipeRow()]);

      final List<SavedRecipeModel> result = await buildDataSource()
          .getSavedRecipes();

      expect(result, <SavedRecipeModel>[savedModel()]);
    });

    test('returns an empty list when there are no saved recipes', () async {
      stubRows(<PMap>[]);
      expect(await buildDataSource().getSavedRecipes(), isEmpty);
    });

    test('maps a PostgrestException to a ServerException', () {
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> filter =
          MockPostgrestFilterBuilder<PList>();
      when(() => client.from('saved_recipes')).thenAnswer((_) => qb);
      when(() => qb.select(any())).thenAnswer((_) => filter);
      when(() => filter.eq('user_id', 'uid')).thenAnswer((_) => filter);
      when(() => filter.order('saved_at', ascending: false)).thenAnswer(
        (_) => _FakeBuilder<PList>.error(
          const PostgrestException(message: 'boom', code: '500'),
        ),
      );

      expect(
        () => buildDataSource().getSavedRecipes(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getRecipeById', () {
    test('maps a detail row to a model', () async {
      final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<PList> filter =
          MockPostgrestFilterBuilder<PList>();
      final MockPostgrestTransformBuilder<PList> ordered =
          MockPostgrestTransformBuilder<PList>();
      when(() => client.from('recipes')).thenAnswer((_) => qb);
      when(() => qb.select(any())).thenAnswer((_) => filter);
      when(() => filter.eq('id', 'r1')).thenAnswer((_) => filter);
      when(
        () => filter.order('step_number', referencedTable: 'recipe_steps'),
      ).thenAnswer((_) => ordered);
      when(
        () => ordered.single(),
      ).thenAnswer((_) => _FakeBuilder<PMap>.value(recipeDetailRow()));

      final RecipeModel result = await buildDataSource().getRecipeById(
        id: 'r1',
      );

      expect(result.title, 'Omelette');
      expect(result.mood, 'cozy');
      expect(result.steps.single.stepNumber, 1);
      expect(result.ingredients.single.name, 'egg');
    });
  });

  group('saveRecipe', () {
    void stubSaveChain({String savedAt = '2026-01-02T03:04:05.000Z'}) {
      // recipes header insert → returns the new id.
      final MockSupabaseQueryBuilder recipesQb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<dynamic> headerInsert =
          MockPostgrestFilterBuilder<dynamic>();
      final MockPostgrestTransformBuilder<PList> headerSelect =
          MockPostgrestTransformBuilder<PList>();
      when(() => client.from('recipes')).thenAnswer((_) => recipesQb);
      when(() => recipesQb.insert(any())).thenAnswer((_) => headerInsert);
      when(() => headerInsert.select('id')).thenAnswer((_) => headerSelect);
      when(() => headerSelect.single()).thenAnswer(
        (_) => _FakeBuilder<PMap>.value(<String, dynamic>{'id': 'rid'}),
      );

      // steps + ingredients batch inserts (awaited for their side effect only).
      for (final String table in <String>[
        'recipe_steps',
        'recipe_ingredients',
      ]) {
        final MockSupabaseQueryBuilder qb = MockSupabaseQueryBuilder();
        when(() => client.from(table)).thenAnswer((_) => qb);
        when(
          () => qb.insert(any()),
        ).thenAnswer((_) => _FakeBuilder<dynamic>.value(null));
      }

      // saved_recipes link insert → returns saved_at.
      final MockSupabaseQueryBuilder savedQb = MockSupabaseQueryBuilder();
      final MockPostgrestFilterBuilder<dynamic> linkInsert =
          MockPostgrestFilterBuilder<dynamic>();
      final MockPostgrestTransformBuilder<PList> linkSelect =
          MockPostgrestTransformBuilder<PList>();
      when(() => client.from('saved_recipes')).thenAnswer((_) => savedQb);
      when(() => savedQb.insert(any())).thenAnswer((_) => linkInsert);
      when(() => linkInsert.select('saved_at')).thenAnswer((_) => linkSelect);
      when(() => linkSelect.single()).thenAnswer(
        (_) => _FakeBuilder<PMap>.value(<String, dynamic>{'saved_at': savedAt}),
      );
    }

    test('persists the recipe and returns the cookbook entry', () async {
      stubSaveChain();

      final SavedRecipeModel result = await buildDataSource().saveRecipe(
        recipe: recipeModel(),
        rating: 5,
        note: 'yum',
        scanId: 'scan1',
      );

      expect(result.id, 'rid');
      expect(result.title, 'Omelette');
      expect(result.cookTimeMinutes, 10);
      expect(result.mood, 'cozy');
      expect(result.rating, 5);
      expect(result.savedAt, DateTime.parse('2026-01-02T03:04:05.000Z'));
    });

    test(
      'falls back to a placeholder title when the recipe has none',
      () async {
        stubSaveChain();

        final SavedRecipeModel result = await buildDataSource().saveRecipe(
          recipe: recipeModel(title: null),
          rating: 3,
        );

        expect(result.title, 'Untitled recipe');
      },
    );

    test('throws InvalidCredentialsException when signed out', () {
      signOut();
      when(
        () => client.from('recipes'),
      ).thenAnswer((_) => MockSupabaseQueryBuilder());

      expect(
        () => buildDataSource().saveRecipe(recipe: recipeModel(), rating: 1),
        throwsA(isA<InvalidCredentialsException>()),
      );
    });
  });

  group('generateRecipes', () {
    Future<List<RecipeModel>> generate(
      RecipeContentGenerator generator,
    ) {
      return buildDataSource(generator: generator).generateRecipes(
        ingredientLines: <String>['2 pcs egg'],
        mood: 'cozy',
        dietaryPreference: 'none',
      );
    }

    test('parses recipes and attaches the requested mood', () async {
      final String json = jsonEncode(<String, dynamic>{
        'recipes': <Map<String, dynamic>>[
          <String, dynamic>{
            'title': 'Scramble',
            'ingredients': <dynamic>[],
            'steps': <dynamic>[],
          },
        ],
      });

      final List<RecipeModel> result = await generate((_) async => json);

      expect(result, hasLength(1));
      expect(result.single.title, 'Scramble');
      expect(result.single.mood, 'cozy');
    });

    test('throws ServerException on an empty response', () {
      expect(
        () => generate((_) async => ''),
        throwsA(isA<ServerException>()),
      );
    });

    test('throws ServerException on whitespace-only response', () {
      expect(
        () => generate((_) async => '   '),
        throwsA(isA<ServerException>()),
      );
    });

    test('throws ServerException on a null response', () {
      expect(
        () => generate((_) async => null),
        throwsA(isA<ServerException>()),
      );
    });

    test('throws ServerException on invalid JSON', () {
      expect(
        () => generate((_) async => 'not json'),
        throwsA(isA<ServerException>()),
      );
    });

    test('throws ServerException when the JSON is not an object', () {
      expect(
        () => generate((_) async => '[]'),
        throwsA(isA<ServerException>()),
      );
    });

    test('throws ServerException when the recipes list is empty', () {
      expect(
        () => generate(
          (_) async => jsonEncode(<String, dynamic>{
            'recipes': <dynamic>[],
          }),
        ),
        throwsA(isA<ServerException>()),
      );
    });

    test('rethrows an AppException from the generator untouched', () {
      expect(
        () => generate((_) async => throw const NetworkException()),
        throwsA(isA<NetworkException>()),
      );
    });

    test('wraps an unexpected generator error in a ServerException', () {
      expect(
        () => generate((_) async => throw Exception('boom')),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
