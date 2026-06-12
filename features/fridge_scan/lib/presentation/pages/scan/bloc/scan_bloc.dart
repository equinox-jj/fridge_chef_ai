import 'dart:typed_data';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/image_source_option/image_source_option.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/extensions/image_source_ext.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/permission_service.dart';
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

/// Drives the fridge-scan journey: resolve the capture permission, pick a
/// photo, let the user preview and confirm it, then run the AI scan.
///
/// No network or AI call happens until the user explicitly confirms, so a
/// blurry or wrong photo never burns API quota (PRD §4.2.2).
class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc(
    this._scanFridge,
    this._permissionService,
    this._imagePicker,
  ) : super(const ScanState()) {
    on<_SourceSelected>(_onSourceSelected);
    on<_ScanConfirmed>(_onConfirmed);
    on<_ScanRetaken>(_onRetaken);
    on<_SettingsRequested>(_onSettingsRequested);
    on<_ScanReset>(_onReset);
  }

  final ScanFridgeUseCase _scanFridge;
  final PermissionService _permissionService;
  final ImagePickerService _imagePicker;

  Future<void> _onSourceSelected(
    _SourceSelected event,
    Emitter<ScanState> emit,
  ) async {
    emit(
      state.copyWith(
        pickStatus: ScanPickStatus.picking,
        permission: null,
      ),
    );

    final PermissionResult permission = await _permissionService.ensure(
      event.source.permission,
    );
    if (!permission.isGranted) {
      emit(
        state.copyWith(
          pickStatus: ScanPickStatus.permissionDenied,
          permission: permission,
        ),
      );
      return;
    }

    final XFile? image = await _imagePicker.pickImage(
      event.source.imageSource,
    );
    if (image == null) {
      // The user backed out of the OS picker — keep any existing preview,
      // otherwise fall back to the idle prompt.
      emit(
        state.copyWith(
          pickStatus: state.pickedImage == null ? ScanPickStatus.idle : ScanPickStatus.ready,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        pickStatus: ScanPickStatus.ready,
        pickedImage: image,
      ),
    );
  }

  Future<void> _onConfirmed(
    _ScanConfirmed event,
    Emitter<ScanState> emit,
  ) async {
    final XFile? image = state.pickedImage;
    if (image == null) return;

    emit(
      state.copyWith(
        scanState: BlocStatus.loading,
        scanFailure: null,
      ),
    );

    final Uint8List bytes = await image.readAsBytes();
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

  void _onRetaken(_ScanRetaken event, Emitter<ScanState> emit) {
    emit(
      state.copyWith(
        pickStatus: ScanPickStatus.idle,
        pickedImage: null,
        scanState: BlocStatus.initial,
        scanFailure: null,
      ),
    );
  }

  Future<void> _onSettingsRequested(
    _SettingsRequested event,
    Emitter<ScanState> emit,
  ) {
    return _permissionService.openSettings();
  }

  void _onReset(_ScanReset event, Emitter<ScanState> emit) {
    emit(const ScanState());
  }
}
