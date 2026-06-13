part of 'recipe_detail_cubit.dart';

@freezed
abstract class RecipeDetailState with _$RecipeDetailState {
  const factory RecipeDetailState({
    /// Drives the page: the loading spinner, the recipe ([success]) or the
    /// error state (offline with nothing cached, or a fetch failure).
    @Default(BlocStatus.initial) BlocStatus status,

    /// The loaded recipe, set once [status] is [BlocStatus.success].
    RecipeEntity? recipe,

    /// Set when [status] is [BlocStatus.error].
    Failure? failure,
  }) = _RecipeDetailState;
}
