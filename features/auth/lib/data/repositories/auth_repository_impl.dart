import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/exception_to_failure.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../mapper/user_mapper.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final UserModel model = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final UserModel model = await _remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() {
    return _guard(() async {
      await _remoteDataSource.signOut();
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) {
    return _guard(() async {
      await _remoteDataSource.forgotPassword(email: email);
      return unit;
    });
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() {
    return _guard(() async {
      final UserModel? model = await _remoteDataSource.getCurrentUser();
      return model?.toEntity();
    });
  }

  /// Runs [call], converting any thrown [AppException] into a [Left] [Failure].
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() call) async {
    try {
      return Right<Failure, T>(await call());
    } on AppException catch (e) {
      return Left<Failure, T>(e.toFailure());
    }
  }
}
