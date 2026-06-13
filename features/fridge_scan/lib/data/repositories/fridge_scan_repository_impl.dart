import 'dart:typed_data';

import 'package:core/constants/network/failure.dart';
import 'package:core/logger/app_logger.dart';
import 'package:core/mixin/repository_guard.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/scan_result_entity.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/fridge_scan_repository.dart';
import '../datasources/ai/fridge_ai_data_source.dart';
import '../datasources/local/fridge_scan_local_data_source.dart';
import '../datasources/remote/fridge_scan_remote_data_source.dart';
import '../mapper/scan_mapper.dart';
import '../models/ingredient_model.dart';
import '../models/scan_model.dart';

class FridgeScanRepositoryImpl with RepositoryGuard implements FridgeScanRepository {
  FridgeScanRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._aiDataSource,
    this.logger,
  );

  final FridgeScanRemoteDataSource _remoteDataSource;
  final FridgeScanLocalDataSource _localDataSource;
  final FridgeAiDataSource _aiDataSource;

  @override
  final AppLogger logger;

  @override
  Future<Either<Failure, ScanResultEntity>> scanFridge(Uint8List bytes) {
    return guard(() async {
      // 1. Analyse the image first — this throws (e.g. NoFoodDetectedException)
      //    for a non-food photo, so nothing is uploaded or persisted below.
      final AiAnalysisResult analysis = await _aiDataSource.analyzeImage(bytes);

      // 2. Upload the validated image to storage and get a signed URL.
      final String imageUrl = await _remoteDataSource.uploadImage(bytes);

      // 3. Persist the scan header.
      final ScanModel scan = await _remoteDataSource.insertScan(
        imageUrl: imageUrl,
        rawAiResponse: analysis.rawResponse,
      );

      // 4. Batch-persist the detected ingredients against the scan.
      final List<IngredientModel> ingredients = await _remoteDataSource.insertIngredients(
        scanId: scan.id ?? '',
        items: analysis.ingredients,
      );

      return ScanResultEntity(
        scan: scan.toEntity(),
        ingredients: ingredients.map((IngredientModel model) => model.toEntity()).toList(),
      );
    });
  }

  @override
  Stream<Either<Failure, UserProfile?>> watchUserProfile() {
    return guardStream(_localDataSource.watchUserProfile());
  }

  @override
  Future<Either<Failure, List<ScanResultEntity>>> getRecentScans({int limit = 10}) {
    return guard(() async {
      final List<ScanWithIngredients> rows = await _remoteDataSource.getRecentScans(limit: limit);
      return rows
          .map(
            (ScanWithIngredients row) => ScanResultEntity(
              scan: row.scan.toEntity(),
              ingredients: row.ingredients.map((IngredientModel model) => model.toEntity()).toList(),
            ),
          )
          .toList();
    });
  }
}
