part of 'save_recipe_cubit.dart';

@freezed
abstract class SaveRecipeState with _$SaveRecipeState {
  const factory SaveRecipeState({
    @Default(BlocStatus.initial) BlocStatus status,
    Failure? failure,
  }) = _SaveRecipeState;
}
