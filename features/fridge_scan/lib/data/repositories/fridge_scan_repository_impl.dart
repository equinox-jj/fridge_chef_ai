import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:core/services/connectivity_service.dart';
import 'package:core/services/image_compression_service_impl.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/scan_result_entity.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/fridge_scan_repository.dart';
import '../datasources/local/fridge_scan_local_data_source.dart';
import '../datasources/remote/fridge_scan_remote_data_source.dart';
import '../mapper/scan_mapper.dart';
import '../models/ingredient_model.dart';
import '../models/scan_model.dart';

class FridgeScanRepositoryImpl
    with RepositoryGuard
    implements FridgeScanRepository {
  FridgeScanRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
    required this._connectivity,
    required this._compressionService,
    required this.logger,
  });

  final FridgeScanRemoteDataSource _remoteDataSource;
  final FridgeScanLocalDataSource _localDataSource;
  final ConnectivityService _connectivity;
  final ImageCompressionService _compressionService;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, ScanResultEntity>> scanFridge({
    required Uint8List bytes,
  }) {
    return guard(() async {
      final Uint8List compressed = await _compressionService.compress(bytes);

      // 1. Analyse the image first — this throws (e.g. NoFoodDetectedException)
      //    for a non-food photo, so nothing is uploaded or persisted below.
      final AiAnalysisResult analysis = await _remoteDataSource.analyzeImage(
        imageBytes: compressed,
      );

      // 2. Upload the validated image to storage and get a signed URL.
      final String imageUrl = await _remoteDataSource.uploadImage(
        bytes: compressed,
      );

      // 3. Persist the scan header.
      final ScanModel scan = await _remoteDataSource.insertScan(
        imageUrl: imageUrl,
        rawAiResponse: analysis.rawResponse,
      );

      // 4. Batch-persist the detected ingredients against the scan.
      final List<IngredientModel> ingredients = await _remoteDataSource
          .insertIngredients(
            scanId: scan.id ?? '',
            items: analysis.ingredients,
          );

      return ScanResultEntity(
        scan: scan.toEntity(),
        ingredients: ingredients
            .map((IngredientModel model) => model.toEntity())
            .toList(),
      );
    });
  }

  @override
  Stream<Either<Failure, UserProfile?>> watchUserProfile() {
    return guardStream(_localDataSource.watchUserProfile());
  }

  @override
  Future<Either<Failure, List<ScanResultEntity>>> getRecentScans({
    int limit = 10,
  }) {
    return guard(() async {
      // Offline-first: when online, refresh the on-device mirror from the
      // backend; then always read from the cache so the home list renders the
      // same whether or not there's a connection. A failed refresh is swallowed
      // (logged) rather than failing the read — the cache still serves what we
      // have. Mirrors the cookbook tab.
      if (await _connectivity.isOnline) {
        await _refreshRecentScansCache(limit);
      }
      final List<ScanWithIngredients> cached = await _localDataSource
          .getRecentScans(limit: limit);
      return cached
          .map(
            (ScanWithIngredients row) => ScanResultEntity(
              scan: row.scan.toEntity(),
              ingredients: row.ingredients
                  .map((IngredientModel model) => model.toEntity())
                  .toList(),
            ),
          )
          .toList();
    });
  }

  /// Pulls the recent scans from the backend and replaces the local cache with
  /// them. Swallows failures so an offline read still falls through to the
  /// cache.
  Future<void> _refreshRecentScansCache(int limit) async {
    try {
      final List<ScanWithIngredients> remote = await _remoteDataSource
          .getRecentScans(limit: limit);
      await _localDataSource.replaceRecentScans(scans: remote);
    } on AppException catch (e, stackTrace) {
      logger.warning(
        'Recent scans refresh failed; serving cache',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
