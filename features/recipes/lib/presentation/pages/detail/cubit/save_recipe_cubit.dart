import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/save_recipe_usecase.dart';

part 'save_recipe_cubit.freezed.dart';
part 'save_recipe_state.dart';

/// Owns the "save to cookbook" action for the recipe being viewed.
///
/// Scoped to the detail route and seeded with the [RecipeEntity] (and its
/// originating scan), so the page only has to hand over the rating and note
/// the user enters in the sheet.
class SaveRecipeCubit extends Cubit<SaveRecipeState> {
  SaveRecipeCubit(
    this._saveRecipe,
    this._recipe, [
    this._scanId,
  ]) : super(const SaveRecipeState());

  final SaveRecipeUseCase _saveRecipe;
  final RecipeEntity _recipe;
  final String? _scanId;

  Future<void> save({required int rating, String? note}) async {
    if (state.status == BlocStatus.loading) return;
    emit(state.copyWith(status: BlocStatus.loading, failure: null));

    final Either<Failure, Unit> result = await _saveRecipe(
      SaveRecipeParams(
        recipe: _recipe,
        rating: rating,
        note: note,
        scanId: _scanId,
      ),
    );

    emit(
      result.fold(
        (Failure l) => state.copyWith(status: BlocStatus.error, failure: l),
        (_) => state.copyWith(status: BlocStatus.success),
      ),
    );
  }
}
