import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local/profile_local_data_source.dart';
import '../datasources/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl with RepositoryGuard implements ProfileRepository {
  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this.logger,
  );

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
  Future<Either<Failure, Unit>> updateDietaryPreference(String preference) {
    return guard(() async {
      // Remote is the source of truth the recipe prompt reads, so write it
      // first; only mirror into the cache once that succeeds.
      await _remoteDataSource.updateDietaryPreference(preference);
      await _localDataSource.updateDietaryPreference(preference);
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
}
