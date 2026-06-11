import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/user_entity.dart';

/// Domain contract for the auth feature. All operations return an
/// `Either<Failure, T>`: [Left] on failure, [Right] on success.
abstract class AuthRepository {
  /// Signs the user in with their [email] and [password].
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  /// Registers a new account with [name], [email] and [password].
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Sends a password-reset email to [email].
  Future<Either<Failure, Unit>> forgotPassword({required String email});

  /// Returns the current session's user, or `null` when not signed in.
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
