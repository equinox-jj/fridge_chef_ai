import 'dart:typed_data';

import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../repositories/profile_repository.dart';

/// Uploads a new avatar image and returns its stored URL.
class UpdateAvatarUseCase implements UseCase<String, Uint8List> {
  const UpdateAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<Either<Failure, String>> call(Uint8List bytes) {
    return _repository.updateAvatar(bytes: bytes);
  }
}
