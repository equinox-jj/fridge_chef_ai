import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/scan_result_entity.dart';
import '../repositories/fridge_scan_repository.dart';

/// Returns the signed-in user's most recent fridge scans, newest first, for the
/// home screen's "Recent scans" list.
class GetRecentScansUseCase implements UseCase<List<ScanResultEntity>, NoParams> {
  const GetRecentScansUseCase(this._repository);

  final FridgeScanRepository _repository;

  @override
  Future<Either<Failure, List<ScanResultEntity>>> call(NoParams params) {
    return _repository.getRecentScans();
  }
}
