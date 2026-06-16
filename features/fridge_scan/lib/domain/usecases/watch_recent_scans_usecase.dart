import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/scan_result_entity.dart';
import '../repositories/fridge_scan_repository.dart';

/// Emits the user's most recent fridge scans (newest first) and re-emits on
/// every change, so the home screen's "Recent scans" list stays live.
class WatchRecentScansUseCase
    implements StreamUseCase<List<ScanResultEntity>, NoParams> {
  const WatchRecentScansUseCase(this._repository);

  final FridgeScanRepository _repository;

  @override
  Stream<Either<Failure, List<ScanResultEntity>>> call(NoParams params) {
    return _repository.watchRecentScans();
  }
}
