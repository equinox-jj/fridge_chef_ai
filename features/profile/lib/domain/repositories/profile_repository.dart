import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

/// Domain contract for the profile feature. All operations return an
/// `Either<Failure, T>`: [Left] on failure, [Right] on success.
abstract class ProfileRepository {
  /// Signs the current user out, clearing the persisted session.
  Future<Either<Failure, Unit>> signOut();
}
