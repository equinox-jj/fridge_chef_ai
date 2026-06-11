import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_profile.dart';
import '../repositories/fridge_scan_repository.dart';

/// Returns the signed-in user's locally cached profile, or `null` when none
/// has been cached yet.
class GetUserProfileUseCase implements UseCase<UserProfile?, NoParams> {
  const GetUserProfileUseCase(this._repository);

  final FridgeScanRepository _repository;

  @override
  Future<Either<Failure, UserProfile?>> call(NoParams params) {
    return _repository.getUserProfile();
  }
}
