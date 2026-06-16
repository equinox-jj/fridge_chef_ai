import 'package:recipes/data/models/recipe_ingredient_model.dart';
import 'package:recipes/data/models/recipe_model.dart';
import 'package:recipes/data/models/recipe_step_model.dart';
import 'package:recipes/data/models/saved_recipe_model.dart';
import 'package:recipes/domain/entities/recipe_entity.dart';
import 'package:recipes/domain/entities/recipe_ingredient_entity.dart';
import 'package:recipes/domain/entities/recipe_step_entity.dart';
import 'package:recipes/domain/entities/saved_recipe_entity.dart';

/// Shared test data builders. Defaults are sensible; override only the fields a
/// given test cares about.
final DateTime tSavedAt = DateTime.utc(2026, 1, 2, 3, 4, 5);

SavedRecipeModel savedModel({
  String id = 'r1',
  String title = 'Pasta',
  DateTime? savedAt,
  int? cookTimeMinutes = 20,
  String? mood = 'cozy',
  int rating = 4,
}) {
  return SavedRecipeModel(
    id: id,
    title: title,
    savedAt: savedAt ?? tSavedAt,
    cookTimeMinutes: cookTimeMinutes,
    mood: mood,
    rating: rating,
  );
}

SavedRecipeEntity savedEntity({
  String id = 'r1',
  String title = 'Pasta',
  DateTime? savedAt,
  int? cookTimeMinutes = 20,
  String? mood = 'cozy',
  int rating = 4,
}) {
  return SavedRecipeEntity(
    id: id,
    title: title,
    savedAt: savedAt ?? tSavedAt,
    cookTimeMinutes: cookTimeMinutes,
    mood: mood,
    rating: rating,
  );
}

RecipeModel recipeModel({
  String? title = 'Omelette',
  String? description = 'Fluffy',
  int? servings = 2,
  int? cookTimeMinutes = 10,
  String? mood = 'cozy',
}) {
  return RecipeModel(
    title: title,
    description: description,
    servings: servings,
    cookTimeMinutes: cookTimeMinutes,
    mood: mood,
    ingredients: <RecipeIngredientModel>[
      RecipeIngredientModel(
        name: 'egg',
        quantity: '2',
        unit: 'pcs',
      ),
    ],
    steps: <RecipeStepModel>[
      RecipeStepModel(
        stepNumber: 1,
        instruction: 'Beat eggs',
        timerSeconds: 0,
      ),
    ],
  );
}

RecipeEntity recipeEntity({
  String title = 'Omelette',
  String? id,
  String? mood = 'cozy',
}) {
  return RecipeEntity(
    title: title,
    id: id,
    description: 'Fluffy',
    servings: 2,
    cookTimeMinutes: 10,
    mood: mood,
    ingredients: <RecipeIngredientEntity>[
      RecipeIngredientEntity(name: 'egg', quantity: '2', unit: 'pcs'),
    ],
    steps: <RecipeStepEntity>[
      RecipeStepEntity(
        stepNumber: 1,
        instruction: 'Beat eggs',
        timerSeconds: 0,
      ),
    ],
  );
}

/// A `saved_recipes`→`recipes` join row, as Supabase returns it.
Map<String, dynamic> savedRecipeRow({
  String id = 'r1',
  String title = 'Pasta',
  int? cookTime = 20,
  String? mood = 'cozy',
  int? rating = 4,
  String savedAt = '2026-01-02T03:04:05.000Z',
}) {
  return <String, dynamic>{
    'rating': rating,
    'saved_at': savedAt,
    'recipes': <String, dynamic>{
      'id': id,
      'title': title,
      'cook_time_minutes': cookTime,
      'mood': mood,
    },
  };
}

/// A full `recipes` detail row with embedded steps/ingredients.
Map<String, dynamic> recipeDetailRow({
  String title = 'Omelette',
  String? mood = 'cozy',
}) {
  return <String, dynamic>{
    'title': title,
    'description': 'Fluffy',
    'servings': 2,
    'cook_time_minutes': 10,
    'mood': mood,
    'recipe_steps': <Map<String, dynamic>>[
      <String, dynamic>{
        'step_number': 1,
        'instruction': 'Beat eggs',
        'timer_seconds': null,
      },
    ],
    'recipe_ingredients': <Map<String, dynamic>>[
      <String, dynamic>{
        'name': 'egg',
        'quantity': '2',
        'unit': 'pcs',
        'is_substitute': false,
      },
    ],
  };
}
