import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

/// Reads the signed-in user's cached profile for the Profile screen header.
class GetProfileUseCase implements UseCase<ProfileEntity?, NoParams> {
  const GetProfileUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, ProfileEntity?>> call(NoParams params) {
    return _repository.getProfile();
  }
}
