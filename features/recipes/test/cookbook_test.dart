import 'dart:async';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes/data/mapper/saved_recipe_mapper.dart';
import 'package:recipes/data/models/saved_recipe_model.dart';
import 'package:recipes/domain/entities/recipe_entity.dart';
import 'package:recipes/domain/entities/saved_recipe_entity.dart';
import 'package:recipes/domain/repositories/recipe_repository.dart';
import 'package:recipes/domain/usecases/get_cookbook_usecase.dart';
import 'package:recipes/presentation/pages/cookbook/bloc/cookbook_bloc.dart';

void main() {
  group('SavedRecipeModel.fromSupabaseRow', () {
    test('flattens the embedded recipe and parses the timestamp', () {
      final SavedRecipeModel model = SavedRecipeModel.fromSupabaseRow(<String, dynamic>{
        'rating': 4,
        'saved_at': '2026-01-02T03:04:05.000Z',
        'recipes': <String, dynamic>{
          'id': 'r1',
          'title': 'Lemon orzo',
          'cook_time_minutes': 25,
          'mood': 'healthy',
        },
      });

      expect(model.id, 'r1');
      expect(model.title, 'Lemon orzo');
      expect(model.cookTimeMinutes, 25);
      expect(model.mood, 'healthy');
      expect(model.rating, 4);
      expect(model.savedAt, DateTime.utc(2026, 1, 2, 3, 4, 5));
    });

    test('defaults a missing title and rating rather than throwing', () {
      final SavedRecipeModel model = SavedRecipeModel.fromSupabaseRow(<String, dynamic>{
        'saved_at': '2026-01-02T03:04:05.000Z',
        'recipes': <String, dynamic>{'id': 'r2'},
      });

      expect(model.title, 'Untitled recipe');
      expect(model.rating, 0);
      expect(model.cookTimeMinutes, isNull);
    });
  });

  group('SavedRecipeModel.toEntity', () {
    test('maps every field across the layer boundary', () {
      final SavedRecipeEntity entity = SavedRecipeModel(
        id: 'r1',
        title: 'Lemon orzo',
        cookTimeMinutes: 25,
        mood: 'healthy',
        rating: 5,
        savedAt: DateTime.utc(2026),
      ).toEntity();

      expect(entity.id, 'r1');
      expect(entity.title, 'Lemon orzo');
      expect(entity.cookTimeMinutes, 25);
      expect(entity.mood, 'healthy');
      expect(entity.rating, 5);
    });
  });

  group('CookbookBloc', () {
    SavedRecipeEntity entity() => SavedRecipeEntity(
      id: 'r1',
      title: 'Lemon orzo',
      rating: 5,
      savedAt: DateTime.utc(2026),
    );

    CookbookBloc buildBloc({
      required Either<Failure, List<SavedRecipeEntity>> result,
      required _FakeConnectivity connectivity,
    }) {
      return CookbookBloc(GetCookbookUseCase(_FakeRepository(result)), connectivity);
    }

    test('started → loading then success with the loaded recipes (online)', () {
      final CookbookBloc bloc = buildBloc(
        result: Right<Failure, List<SavedRecipeEntity>>(<SavedRecipeEntity>[entity()]),
        connectivity: _FakeConnectivity(online: true),
      );

      expectLater(
        bloc.stream,
        emitsInOrder(<Matcher>[
          isA<CookbookState>().having((CookbookState s) => s.isOffline, 'isOffline', false),
          isA<CookbookState>().having((CookbookState s) => s.status, 'status', BlocStatus.loading),
          isA<CookbookState>()
              .having((CookbookState s) => s.status, 'status', BlocStatus.success)
              .having((CookbookState s) => s.recipes, 'recipes', hasLength(1)),
        ]),
      );

      bloc.add(const CookbookEvent.started());
      addTearDown(bloc.close);
    });

    test('started → empty status when the cookbook has no recipes', () {
      final CookbookBloc bloc = buildBloc(
        result: Right<Failure, List<SavedRecipeEntity>>(<SavedRecipeEntity>[]),
        connectivity: _FakeConnectivity(online: true),
      );

      expectLater(
        bloc.stream,
        emitsThrough(
          isA<CookbookState>().having((CookbookState s) => s.status, 'status', BlocStatus.empty),
        ),
      );

      bloc.add(const CookbookEvent.started());
      addTearDown(bloc.close);
    });

    test('started offline marks the state offline but still serves the cache', () {
      final CookbookBloc bloc = buildBloc(
        result: Right<Failure, List<SavedRecipeEntity>>(<SavedRecipeEntity>[entity()]),
        connectivity: _FakeConnectivity(online: false),
      );

      expectLater(
        bloc.stream,
        emitsThrough(
          isA<CookbookState>()
              .having((CookbookState s) => s.isOffline, 'isOffline', true)
              .having((CookbookState s) => s.status, 'status', BlocStatus.success),
        ),
      );

      bloc.add(const CookbookEvent.started());
      addTearDown(bloc.close);
    });

    test('a load failure surfaces the error status', () {
      final CookbookBloc bloc = buildBloc(
        result: Left<Failure, List<SavedRecipeEntity>>(const CacheFailure()),
        connectivity: _FakeConnectivity(online: true),
      );

      expectLater(
        bloc.stream,
        emitsThrough(
          isA<CookbookState>().having((CookbookState s) => s.status, 'status', BlocStatus.error),
        ),
      );

      bloc.add(const CookbookEvent.started());
      addTearDown(bloc.close);
    });
  });
}

/// A [RecipeRepository] that only answers `getCookbook` — enough to drive the
/// use case under test without a real backend or database.
class _FakeRepository implements RecipeRepository {
  _FakeRepository(this._cookbook);

  final Either<Failure, List<SavedRecipeEntity>> _cookbook;

  @override
  Future<Either<Failure, List<SavedRecipeEntity>>> getCookbook() async => _cookbook;

  @override
  Future<Either<Failure, List<RecipeEntity>>> generateRecipes({
    required List<RecipeSeedIngredient> ingredients,
    required String mood,
    required String dietaryPreference,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, RecipeEntity>> getRecipeDetail(String id) => throw UnimplementedError();

  @override
  Future<Either<Failure, String>> getDietaryPreference() => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> saveRecipe({
    required RecipeEntity recipe,
    required int rating,
    String? note,
    String? scanId,
  }) => throw UnimplementedError();
}

class _FakeConnectivity implements ConnectivityService {
  _FakeConnectivity({required this.online});

  final bool online;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  @override
  Future<bool> get isOnline async => online;

  @override
  Stream<bool> get onStatusChanged => _controller.stream;
}
