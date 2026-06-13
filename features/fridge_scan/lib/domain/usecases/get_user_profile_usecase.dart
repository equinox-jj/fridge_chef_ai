import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_profile.dart';
import '../repositories/fridge_scan_repository.dart';

/// Emits the signed-in user's locally cached profile (or `null` when none has
/// been cached yet) and re-emits whenever it changes, so the home screen stays
/// in sync with profile edits in real time.
class GetUserProfileUseCase implements StreamUseCase<UserProfile?, NoParams> {
  const GetUserProfileUseCase(this._repository);

  final FridgeScanRepository _repository;

  @override
  Stream<Either<Failure, UserProfile?>> call(NoParams params) {
    return _repository.watchUserProfile();
  }
}
