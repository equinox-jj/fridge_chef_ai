import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/profile_repository.dart';

/// Returns the number of scans the user has run, shown on the Profile screen's
/// scan-history row.
class GetScanCountUseCase implements UseCase<int, NoParams> {
  const GetScanCountUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return _repository.getScanCount();
  }
}
