import 'dart:typed_data';

import 'package:core/constants/network/failure.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/image_picker/image_picker.dart';

import '../../../../domain/entities/ingredient_entity.dart';
import '../../../../domain/entities/scan_entity.dart';
import '../../../../domain/entities/scan_result_entity.dart';
import '../../../../domain/usecases/scan_fridge_usecase.dart';

part 'scan_bloc.freezed.dart';
part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc(this._scanFridge) : super(const ScanState.initial()) {
    on<ScanConfirmed>(_onConfirmed);
    on<ScanReset>(_onReset);
  }

  final ScanFridgeUseCase _scanFridge;

  Future<void> _onConfirmed(
    ScanConfirmed event,
    Emitter<ScanState> emit,
  ) async {
    emit(const ScanState.loading());
    final Uint8List bytes = await event.file.readAsBytes();
    final Either<Failure, ScanResultEntity> result = await _scanFridge(
      ScanFridgeParams(imageBytes: bytes),
    );
    emit(
      result.fold(
        (Failure failure) => ScanState.error(failure),
        (ScanResultEntity data) => ScanState.done(data.scan, data.ingredients),
      ),
    );
  }

  void _onReset(ScanReset event, Emitter<ScanState> emit) {
    emit(const ScanState.initial());
  }
}
