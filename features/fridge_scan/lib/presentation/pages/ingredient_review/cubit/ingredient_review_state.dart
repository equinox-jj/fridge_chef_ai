part of 'ingredient_review_cubit.dart';

@freezed
abstract class IngredientReviewState with _$IngredientReviewState {
  const factory IngredientReviewState({
    @Default(<IngredientEntity>[]) List<IngredientEntity> items,
  }) = _IngredientReviewState;
}
