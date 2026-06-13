import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/scan_result_entity.dart';
import '../repositories/fridge_scan_repository.dart';

/// Returns the user's full scan history (newest first) for the scan-history
/// screen. Unlike the home screen's short "Recent scans" preview, this pulls a
/// larger window so the whole loop is browsable.
class GetScanHistoryUseCase implements UseCase<List<ScanResultEntity>, NoParams> {
  const GetScanHistoryUseCase(this._repository);

  /// How many scans the history screen loads. Generous for a personal log while
  /// still bounding the query.
  static const int _historyLimit = 50;

  final FridgeScanRepository _repository;

  @override
  Future<Either<Failure, List<ScanResultEntity>>> call(NoParams params) {
    return _repository.getRecentScans(limit: _historyLimit);
  }
}
