part of 'recipe_generation_bloc.dart';

@freezed
abstract class RecipeGenerationEvent with _$RecipeGenerationEvent {
  /// Load the user's dietary preference for the mood screen.
  const factory RecipeGenerationEvent.started() = _Started;

  /// The user picked a mood chip.
  const factory RecipeGenerationEvent.moodSelected(RecipeMood mood) =
      _MoodSelected;

  /// Generate (or regenerate) recipes from the current mood and ingredients.
  const factory RecipeGenerationEvent.generateRequested() = _GenerateRequested;
}
