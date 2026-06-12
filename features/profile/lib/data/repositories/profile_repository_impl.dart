import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl with RepositoryGuard implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource, this.logger);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, Unit>> signOut() {
    return guard(() async {
      await _remoteDataSource.signOut();
      return unit;
    });
  }
}
