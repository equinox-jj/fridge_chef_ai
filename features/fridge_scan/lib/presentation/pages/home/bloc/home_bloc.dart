import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/scan_result_entity.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((HomeEvent event, Emitter<HomeState> emit) {});
  }
}
