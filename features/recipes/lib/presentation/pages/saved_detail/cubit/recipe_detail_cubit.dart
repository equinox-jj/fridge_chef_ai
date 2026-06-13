import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/get_recipe_detail_usecase.dart';

part 'recipe_detail_cubit.freezed.dart';
part 'recipe_detail_state.dart';

/// Loads a saved recipe's full detail by id for the cookbook detail screen.
///
/// Scoped to the detail route and seeded with the recipe [_id]; the load is
/// cache-first (handled by the repository), so it works offline once the recipe
/// has been opened online. [load] is also the retry entry point for the error
/// state.
class RecipeDetailCubit extends Cubit<RecipeDetailState> {
  RecipeDetailCubit(this._getRecipeDetail, this._id) : super(const RecipeDetailState());

  final GetRecipeDetailUseCase _getRecipeDetail;
  final String _id;

  Future<void> load() async {
    if (state.status == BlocStatus.loading) return;
    emit(state.copyWith(status: BlocStatus.loading, failure: null));

    final Either<Failure, RecipeEntity> result = await _getRecipeDetail(_id);

    emit(
      result.fold(
        (Failure failure) => state.copyWith(status: BlocStatus.error, failure: failure),
        (RecipeEntity recipe) => state.copyWith(status: BlocStatus.success, recipe: recipe),
      ),
    );
  }
}
