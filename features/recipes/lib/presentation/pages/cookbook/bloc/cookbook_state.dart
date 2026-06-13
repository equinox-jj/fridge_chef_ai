part of 'cookbook_bloc.dart';

@freezed
abstract class CookbookState with _$CookbookState {
  const factory CookbookState({
    /// Drives the page: loading skeleton, the grid ([success]), the empty
    /// state ([empty]) or the error state.
    @Default(BlocStatus.initial) BlocStatus status,

    /// The saved recipes to render, newest first.
    @Default(<SavedRecipeEntity>[]) List<SavedRecipeEntity> recipes,

    /// Set when [status] is [BlocStatus.error].
    Failure? failure,
  }) = _CookbookState;
}
