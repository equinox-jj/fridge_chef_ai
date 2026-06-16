import 'package:core/constants/network/failure.dart';
import 'package:core/router/args/recipe_generation_args.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipes/domain/entities/recipe_entity.dart';
import 'package:recipes/domain/entities/saved_recipe_entity.dart';
import 'package:recipes/domain/usecases/generate_recipes_usecase.dart';
import 'package:recipes/domain/usecases/get_cookbook_usecase.dart';
import 'package:recipes/domain/usecases/get_dietary_preference_usecase.dart';
import 'package:recipes/domain/usecases/get_recipe_detail_usecase.dart';
import 'package:recipes/domain/usecases/save_recipe_usecase.dart';
import 'package:recipes/domain/usecases/watch_cookbook_usecase.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockRecipeRepository repository;

  setUpAll(() {
    registerFallbackValue(<RecipeSeedIngredient>[]);
  });

  setUp(() => repository = MockRecipeRepository());

  const Failure failure = ServerFailure();

  group('GetCookbookUseCase', () {
    late GetCookbookUseCase useCase;
    setUp(() => useCase = GetCookbookUseCase(repository));

    test('forwards the repository success result', () async {
      final List<SavedRecipeEntity> recipes = <SavedRecipeEntity>[
        savedEntity(),
      ];
      when(() => repository.getCookbook()).thenAnswer(
        (_) async => Right<Failure, List<SavedRecipeEntity>>(recipes),
      );

      final Either<Failure, List<SavedRecipeEntity>> result = await useCase(
        const NoParams(),
      );

      expect(result, Right<Failure, List<SavedRecipeEntity>>(recipes));
      verify(() => repository.getCookbook()).called(1);
    });

    test('forwards the repository failure result', () async {
      when(() => repository.getCookbook()).thenAnswer(
        (_) async => const Left<Failure, List<SavedRecipeEntity>>(failure),
      );

      final Either<Failure, List<SavedRecipeEntity>> result = await useCase(
        const NoParams(),
      );

      expect(result, const Left<Failure, List<SavedRecipeEntity>>(failure));
    });
  });

  group('WatchCookbookUseCase', () {
    late WatchCookbookUseCase useCase;
    setUp(() => useCase = WatchCookbookUseCase(repository));

    test('forwards the repository stream', () {
      final List<SavedRecipeEntity> recipes = <SavedRecipeEntity>[
        savedEntity(),
      ];
      when(() => repository.watchCookbook()).thenAnswer(
        (_) => Stream<Either<Failure, List<SavedRecipeEntity>>>.fromIterable(
          <Either<Failure, List<SavedRecipeEntity>>>[
            Right<Failure, List<SavedRecipeEntity>>(recipes),
            const Left<Failure, List<SavedRecipeEntity>>(failure),
          ],
        ),
      );

      expect(
        useCase(const NoParams()),
        emitsInOrder(<Object>[
          Right<Failure, List<SavedRecipeEntity>>(recipes),
          const Left<Failure, List<SavedRecipeEntity>>(failure),
        ]),
      );
      verify(() => repository.watchCookbook()).called(1);
    });
  });

  group('GetDietaryPreferenceUseCase', () {
    late GetDietaryPreferenceUseCase useCase;
    setUp(() => useCase = GetDietaryPreferenceUseCase(repository));

    test('forwards the preference on success', () async {
      when(
        () => repository.getDietaryPreference(),
      ).thenAnswer((_) async => const Right<Failure, String>('vegan'));

      final Either<Failure, String> result = await useCase(const NoParams());

      expect(result, const Right<Failure, String>('vegan'));
    });

    test('forwards the failure', () async {
      when(
        () => repository.getDietaryPreference(),
      ).thenAnswer((_) async => const Left<Failure, String>(failure));

      expect(
        await useCase(const NoParams()),
        const Left<Failure, String>(failure),
      );
    });
  });

  group('GetRecipeDetailUseCase', () {
    late GetRecipeDetailUseCase useCase;
    setUp(() => useCase = GetRecipeDetailUseCase(repository));

    test('passes the id through and returns the recipe', () async {
      final RecipeEntity recipe = recipeEntity();
      when(
        () => repository.getRecipeDetail(id: 'r1'),
      ).thenAnswer((_) async => Right<Failure, RecipeEntity>(recipe));

      final Either<Failure, RecipeEntity> result = await useCase('r1');

      expect(result, Right<Failure, RecipeEntity>(recipe));
      verify(() => repository.getRecipeDetail(id: 'r1')).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.getRecipeDetail(id: any(named: 'id')),
      ).thenAnswer((_) async => const Left<Failure, RecipeEntity>(failure));

      expect(await useCase('r1'), const Left<Failure, RecipeEntity>(failure));
    });
  });

  group('GenerateRecipesUseCase', () {
    late GenerateRecipesUseCase useCase;
    setUp(() => useCase = GenerateRecipesUseCase(repository));

    final List<RecipeSeedIngredient> ingredients = <RecipeSeedIngredient>[
      const RecipeSeedIngredient(name: 'egg', quantity: '2', unit: 'pcs'),
    ];

    test('forwards every param and returns recipes', () async {
      final List<RecipeEntity> recipes = <RecipeEntity>[recipeEntity()];
      when(
        () => repository.generateRecipes(
          ingredients: ingredients,
          mood: 'cozy',
          dietaryPreference: 'none',
        ),
      ).thenAnswer((_) async => Right<Failure, List<RecipeEntity>>(recipes));

      final Either<Failure, List<RecipeEntity>> result = await useCase(
        GenerateRecipesParams(
          ingredients: ingredients,
          mood: 'cozy',
          dietaryPreference: 'none',
        ),
      );

      expect(result, Right<Failure, List<RecipeEntity>>(recipes));
      verify(
        () => repository.generateRecipes(
          ingredients: ingredients,
          mood: 'cozy',
          dietaryPreference: 'none',
        ),
      ).called(1);
    });

    test('forwards the failure', () async {
      when(
        () => repository.generateRecipes(
          ingredients: any(named: 'ingredients'),
          mood: any(named: 'mood'),
          dietaryPreference: any(named: 'dietaryPreference'),
        ),
      ).thenAnswer(
        (_) async => const Left<Failure, List<RecipeEntity>>(failure),
      );

      final Either<Failure, List<RecipeEntity>> result = await useCase(
        GenerateRecipesParams(
          ingredients: ingredients,
          mood: 'cozy',
          dietaryPreference: 'none',
        ),
      );

      expect(result, const Left<Failure, List<RecipeEntity>>(failure));
    });
  });

  group('SaveRecipeUseCase', () {
    late SaveRecipeUseCase useCase;
    setUp(() => useCase = SaveRecipeUseCase(repository));

    test('forwards every param and returns unit on success', () async {
      final RecipeEntity recipe = recipeEntity();
      when(
        () => repository.saveRecipe(
          recipe: recipe,
          rating: 5,
          note: 'yum',
          scanId: 'scan1',
        ),
      ).thenAnswer((_) async => const Right<Failure, Unit>(unit));

      final Either<Failure, Unit> result = await useCase(
        SaveRecipeParams(
          recipe: recipe,
          rating: 5,
          note: 'yum',
          scanId: 'scan1',
        ),
      );

      expect(result, const Right<Failure, Unit>(unit));
      verify(
        () => repository.saveRecipe(
          recipe: recipe,
          rating: 5,
          note: 'yum',
          scanId: 'scan1',
        ),
      ).called(1);
    });

    test('forwards optional nulls (no note/scanId) and the failure', () async {
      final RecipeEntity recipe = recipeEntity();
      when(
        () => repository.saveRecipe(
          recipe: recipe,
          rating: 3,
          note: null,
          scanId: null,
        ),
      ).thenAnswer((_) async => const Left<Failure, Unit>(failure));

      final Either<Failure, Unit> result = await useCase(
        SaveRecipeParams(recipe: recipe, rating: 3),
      );

      expect(result, const Left<Failure, Unit>(failure));
      verify(
        () => repository.saveRecipe(
          recipe: recipe,
          rating: 3,
          note: null,
          scanId: null,
        ),
      ).called(1);
    });
  });
}
