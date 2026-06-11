import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/exception_to_failure.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/remote/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, Unit>> signOut() {
    return _guard(() async {
      await _remoteDataSource.signOut();
      return unit;
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
