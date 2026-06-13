import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/router/arguments/recipe_generation_args.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/generate_recipes_usecase.dart';
import '../../../../domain/usecases/get_dietary_preference_usecase.dart';
import '../../../recipe_mood.dart';

part 'recipe_generation_bloc.freezed.dart';
part 'recipe_generation_event.dart';
part 'recipe_generation_state.dart';

/// Drives the recipe-generation journey for a single set of ingredients:
/// pick a mood → generate with Gemini → show three results, with a regenerate
/// that re-runs the same inputs (PRD §4.3, §6.2).
///
/// The reviewed ingredients and originating scan are fixed for the lifetime of
/// the bloc (seeded from the route's [RecipeGenerationArgs]); the dietary
/// preference is loaded once on [RecipeGenerationEvent.started] and folded into
/// every prompt.
class RecipeGenerationBloc extends Bloc<RecipeGenerationEvent, RecipeGenerationState> {
  RecipeGenerationBloc(
    this._generateRecipes,
    this._getDietaryPreference, {
    required RecipeGenerationArgs args,
  }) : super(
         RecipeGenerationState(
           ingredients: args.ingredients,
           scanId: args.scanId,
         ),
       ) {
    on<_Started>(_onStarted);
    on<_MoodSelected>(_onMoodSelected);
    on<_GenerateRequested>(_onGenerate);
  }

  final GenerateRecipesUseCase _generateRecipes;
  final GetDietaryPreferenceUseCase _getDietaryPreference;

  Future<void> _onStarted(_Started event, Emitter<RecipeGenerationState> emit) async {
    final Either<Failure, String> result = await _getDietaryPreference(const NoParams());
    // A failed read is non-fatal — fall back to "none" so the user can still
    // pick a mood and generate.
    final DietaryPreference diet = result.fold(
      (_) => DietaryPreference.none,
      DietaryPreference.fromValue,
    );
    emit(state.copyWith(dietaryPreference: diet));
  }

  void _onMoodSelected(_MoodSelected event, Emitter<RecipeGenerationState> emit) {
    emit(state.copyWith(mood: event.mood));
  }

  Future<void> _onGenerate(_GenerateRequested event, Emitter<RecipeGenerationState> emit) async {
    final RecipeMood? mood = state.mood;
    if (mood == null) return;

    emit(state.copyWith(status: RecipeGenStatus.generating, failure: null));

    final Either<Failure, List<RecipeEntity>> result = await _generateRecipes(
      GenerateRecipesParams(
        ingredients: state.ingredients,
        mood: mood.value,
        dietaryPreference: state.dietaryPreference.value,
      ),
    );

    emit(
      result.fold(
        (Failure l) => state.copyWith(status: RecipeGenStatus.error, failure: l),
        (List<RecipeEntity> r) => state.copyWith(status: RecipeGenStatus.results, recipes: r),
      ),
    );
  }
}
