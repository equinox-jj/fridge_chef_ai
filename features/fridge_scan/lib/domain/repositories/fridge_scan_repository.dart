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

  /// Returns the locally cached profile, or `null` when none is cached.
  Future<Either<Failure, UserProfile?>> getUserProfile();
}
