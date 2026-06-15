import '../../domain/entities/recipe_entity.dart';
import '../../domain/entities/recipe_ingredient_entity.dart';
import '../../domain/entities/recipe_step_entity.dart';
import '../models/recipe_ingredient_model.dart';
import '../models/recipe_model.dart';
import '../models/recipe_step_model.dart';

/// Maps the data-layer [RecipeModel] to the domain [RecipeEntity].
extension RecipeModelMapper on RecipeModel {
  RecipeEntity toEntity() {
    return RecipeEntity(
      title: title ?? 'Untitled recipe',
      description: description,
      servings: servings,
      cookTimeMinutes: cookTimeMinutes,
      mood: mood,
      ingredients: ingredients
          .map((RecipeIngredientModel m) => m.toEntity())
          .toList(),
      steps: steps.map((RecipeStepModel m) => m.toEntity()).toList(),
    );
  }
}

extension RecipeIngredientModelMapper on RecipeIngredientModel {
  RecipeIngredientEntity toEntity() {
    return RecipeIngredientEntity(
      name: name,
      quantity: quantity,
      unit: unit,
      isSubstitute: isSubstitute,
    );
  }
}

extension RecipeStepModelMapper on RecipeStepModel {
  RecipeStepEntity toEntity() {
    return RecipeStepEntity(
      stepNumber: stepNumber ?? 0,
      instruction: instruction ?? '',
      timerSeconds: timerSeconds,
    );
  }
}

/// Maps the domain [RecipeEntity] back to a [RecipeModel] for persistence.
extension RecipeEntityMapper on RecipeEntity {
  RecipeModel toModel() {
    return RecipeModel(
      title: title,
      description: description,
      servings: servings,
      cookTimeMinutes: cookTimeMinutes,
      mood: mood,
      ingredients: ingredients
          .map((RecipeIngredientEntity e) => e.toModel())
          .toList(),
      steps: steps.map((RecipeStepEntity e) => e.toModel()).toList(),
    );
  }
}

extension RecipeIngredientEntityMapper on RecipeIngredientEntity {
  RecipeIngredientModel toModel() {
    return RecipeIngredientModel(
      name: name,
      quantity: quantity,
      unit: unit,
      isSubstitute: isSubstitute,
    );
  }
}

extension RecipeStepEntityMapper on RecipeStepEntity {
  RecipeStepModel toModel() {
    return RecipeStepModel(
      stepNumber: stepNumber,
      instruction: instruction,
      timerSeconds: timerSeconds,
    );
  }
}
