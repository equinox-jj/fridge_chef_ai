import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../mapper/user_mapper.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl with RepositoryGuard implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource, this.logger);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) {
    return guard(() async {
      final UserModel model = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      await _localDataSource.cacheUser(model);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return guard(() async {
      final UserModel model = await _remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      await _localDataSource.cacheUser(model);
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) {
    return guard(() async {
      await _remoteDataSource.forgotPassword(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() {
    return guard(() async {
      try {
        final UserModel? model = await _remoteDataSource.getCurrentUser();
        if (model != null) {
          await _localDataSource.cacheUser(model);
        }
        return model?.toEntity();
      } on NetworkException {
        // Offline: serve the last profile we cached locally.
        final UserModel? cached = await _localDataSource.getCachedUser();
        return cached?.toEntity();
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() {
    return guard(() async {
      final UserModel? cached = await _localDataSource.getCachedUser();
      return cached?.toEntity();
    });
  }
}
