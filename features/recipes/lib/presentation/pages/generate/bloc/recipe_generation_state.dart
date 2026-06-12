part of 'recipe_generation_bloc.dart';

/// Which screen of the generation flow is showing.
enum RecipeGenStatus {
  /// Picking a mood (the initial mood screen).
  selecting,

  /// Waiting on Gemini — the "writing recipes" loader.
  generating,

  /// Three recipes are ready.
  results,

  /// Generation failed; [RecipeGenerationState.failure] explains why.
  error,
}

@freezed
abstract class RecipeGenerationState with _$RecipeGenerationState {
  const factory RecipeGenerationState({
    /// Reviewed ingredients to build recipes from (fixed for this flow).
    @Default(<RecipeSeedIngredient>[]) List<RecipeSeedIngredient> ingredients,

    /// Originating scan id, threaded through to a saved recipe.
    String? scanId,

    /// Dietary preference pre-filled from the profile; defaults to none.
    @Default(DietaryPreference.none) DietaryPreference dietaryPreference,

    /// The currently selected mood, or null until the user picks one.
    RecipeMood? mood,

    /// Current screen of the flow.
    @Default(RecipeGenStatus.selecting) RecipeGenStatus status,

    /// The generated recipes, once available.
    @Default(<RecipeEntity>[]) List<RecipeEntity> recipes,

    /// Why the last generation failed, when [status] is [RecipeGenStatus.error].
    Failure? failure,
  }) = _RecipeGenerationState;
}
