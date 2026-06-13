import 'dart:typed_data';

import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../entities/scan_result_entity.dart';
import '../entities/user_profile.dart';

/// Domain contract for the fridge-scan feature.
abstract class FridgeScanRepository {
  /// Runs the full scan pipeline for the given image [bytes]: upload to
  /// storage, analyse with AI, persist the scan header and its ingredients.
  Future<Either<Failure, ScanResultEntity>> scanFridge(Uint8List bytes);

  /// Emits the locally cached profile (or `null` when none is cached) and
  /// re-emits on every change, so the UI tracks profile edits in real time.
  Stream<Either<Failure, UserProfile?>> watchUserProfile();

  /// Returns the user's most recent scans (newest first), each with its
  /// detected ingredients, capped at [limit].
  Future<Either<Failure, List<ScanResultEntity>>> getRecentScans({int limit});
}
