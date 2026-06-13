import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/profile_entity.dart';

/// Domain contract for the profile feature. All operations return an
/// `Either<Failure, T>`: [Left] on failure, [Right] on success.
abstract class ProfileRepository {
  /// Reads the signed-in user's cached profile (name, email, avatar, dietary
  /// preference), or `null` when none has been cached yet.
  Future<Either<Failure, ProfileEntity?>> getProfile();

  /// Returns how many fridge scans the user has run, for the scan-history row.
  Future<Either<Failure, int>> getScanCount();

  /// Persists a new dietary [preference] token (remote source of truth, then
  /// the on-device cache so the UI and offline reads stay in sync).
  Future<Either<Failure, Unit>> updateDietaryPreference(String preference);

  /// Signs the current user out, clearing the persisted session.
  Future<Either<Failure, Unit>> signOut();
}
