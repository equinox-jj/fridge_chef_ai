import 'package:flutter_test/flutter_test.dart';
import 'package:recipes/data/mapper/recipe_mapper.dart';
import 'package:recipes/data/models/recipe_ingredient_model.dart';
import 'package:recipes/data/models/recipe_model.dart';
import 'package:recipes/data/models/recipe_step_model.dart';
import 'package:recipes/domain/entities/recipe_entity.dart';
import 'package:recipes/presentation/dietary_preference.dart';
import 'package:recipes/presentation/recipe_mood.dart';

void main() {
  group('RecipeMood.fromValue', () {
    test('resolves a known mood', () {
      expect(RecipeMood.fromValue('quick'), RecipeMood.quick);
    });

    test('falls back to simple for an unknown value', () {
      expect(RecipeMood.fromValue('nonsense'), RecipeMood.simple);
      expect(RecipeMood.fromValue(null), RecipeMood.simple);
    });
  });

  group('DietaryPreference.fromValue', () {
    test('resolves the hyphenated gluten-free value', () {
      expect(DietaryPreference.fromValue('gluten-free'), DietaryPreference.glutenFree);
    });

    test('falls back to none for an unknown value', () {
      expect(DietaryPreference.fromValue(null), DietaryPreference.none);
    });
  });

  group('RecipeModel.toEntity', () {
    test('maps header, ingredients (substitute flag) and steps', () {
      final RecipeModel model = RecipeModel(
        title: 'Feta bowl',
        description: 'Warm and bright.',
        servings: 4,
        cookTimeMinutes: 25,
        mood: 'healthy',
        ingredients: <RecipeIngredientModel>[
          RecipeIngredientModel(name: 'feta', quantity: '120', unit: 'g'),
          RecipeIngredientModel(name: 'lemon', quantity: '1', isSubstitute: true),
        ],
        steps: <RecipeStepModel>[
          RecipeStepModel(stepNumber: 1, instruction: 'Cook rice', timerSeconds: 600),
        ],
      );

      final RecipeEntity entity = model.toEntity();

      expect(entity.title, 'Feta bowl');
      expect(entity.servings, 4);
      expect(entity.mood, 'healthy');
      expect(entity.ingredients, hasLength(2));
      expect(entity.ingredients[1].isSubstitute, isTrue);
      expect(entity.steps.single.timerSeconds, 600);
    });

    test('defaults a missing title rather than throwing', () {
      expect(RecipeModel().toEntity().title, 'Untitled recipe');
    });
  });
}
