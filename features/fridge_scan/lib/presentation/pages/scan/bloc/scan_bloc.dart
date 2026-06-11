import 'dart:typed_data';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';
import 'package:dependencies/image_picker/image_picker.dart';

import '../../../../domain/entities/ingredient_entity.dart';
import '../../../../domain/entities/scan_entity.dart';
import '../../../../domain/entities/scan_result_entity.dart';
import '../../../../domain/usecases/scan_fridge_usecase.dart';

part 'scan_bloc.freezed.dart';
part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc(this._scanFridge) : super(const ScanState()) {
    on<_ScanConfirmed>(_onConfirmed);
    on<_ScanReset>(_onReset);
  }

  final ScanFridgeUseCase _scanFridge;

  Future<void> _onConfirmed(
    _ScanConfirmed event,
    Emitter<ScanState> emit,
  ) async {
    emit(
      state.copyWith(
        scanState: BlocStatus.loading,
      ),
    );

    final Uint8List bytes = await event.file.readAsBytes();
    final Either<Failure, ScanResultEntity> result = await _scanFridge(
      ScanFridgeParams(imageBytes: bytes),
    );
    emit(
      result.fold(
        (Failure l) => state.copyWith(
          scanState: BlocStatus.error,
          scanFailure: l,
        ),
        (ScanResultEntity r) => state.copyWith(
          scanState: BlocStatus.success,
          scanResponse: r.scan,
          ingredientsResponse: r.ingredients,
        ),
      ),
    );
  }

  void _onReset(_ScanReset event, Emitter<ScanState> emit) {
    final List<IngredientEntity>? ingredientsResponse = state.ingredientsResponse?..clear();

    emit(
      state.copyWith(
        scanState: BlocStatus.initial,
        scanResponse: null,
        ingredientsResponse: ingredientsResponse,
      ),
    );
  }
}
