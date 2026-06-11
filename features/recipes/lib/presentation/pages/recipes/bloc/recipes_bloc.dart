import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'recipes_bloc.freezed.dart';
part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(RecipesState()) {
    on<RecipesEvent>((RecipesEvent event, Emitter<RecipesState> emit) {});
  }
}
