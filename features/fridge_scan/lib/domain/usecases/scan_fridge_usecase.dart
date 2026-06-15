import 'dart:typed_data';

import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/scan_result_entity.dart';
import '../repositories/fridge_scan_repository.dart';

class ScanFridgeParams {
  const ScanFridgeParams({required this.imageBytes});

  final Uint8List imageBytes;
}

/// Scans the fridge from a captured image and returns the detected ingredients.
class ScanFridgeUseCase implements UseCase<ScanResultEntity, ScanFridgeParams> {
  const ScanFridgeUseCase(this._repository);

  final FridgeScanRepository _repository;

  @override
  Future<Either<Failure, ScanResultEntity>> call(ScanFridgeParams params) {
    return _repository.scanFridge(bytes: params.imageBytes);
  }
}
