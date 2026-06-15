import 'dart:typed_data';

import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local/profile_local_data_source.dart';
import '../datasources/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl with RepositoryGuard implements ProfileRepository {
  ProfileRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
    required this.logger,
  });

  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, ProfileEntity?>> getProfile() {
    return guard(() => _localDataSource.getProfile());
  }

  @override
  Future<Either<Failure, int>> getScanCount() {
    return guard(() => _remoteDataSource.getScanCount());
  }

  @override
  Future<Either<Failure, Unit>> updateDietaryPreference({
    required String preference,
  }) {
    return guard(() async {
      // Remote is the source of truth the recipe prompt reads, so write it
      // first; only mirror into the cache once that succeeds.
      await Future.wait(<Future<void>>[
        _remoteDataSource.updateDietaryPreference(preference: preference),
        _localDataSource.updateDietaryPreference(preference: preference),
      ]);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() {
    return guard(() async {
      await _remoteDataSource.signOut();
      return unit;
    });
  }

  @override
  Future<Either<Failure, String>> updateAvatar({required Uint8List bytes}) {
    return guard(() async {
      // Upload first, then write the resulting URL remotely (source of truth),
      // then mirror it into the cache so the header updates immediately.
      final String url = await _remoteDataSource.uploadAvatar(bytes: bytes);
      await Future.wait(<Future<void>>[
        _remoteDataSource.updateAvatarUrl(url: url),
        _localDataSource.updateAvatarUrl(url: url),
      ]);
      return url;
    });
  }

  @override
  Future<Either<Failure, Unit>> removeAvatar() {
    return guard(() async {
      await Future.wait(<Future<void>>[
        _remoteDataSource.deleteAvatar(),
        _remoteDataSource.updateAvatarUrl(url: null),
        _localDataSource.updateAvatarUrl(url: null),
      ]);
      return unit;
    });
  }
}
