import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/network/exception_to_failure.dart';
import 'package:core/constants/network/failure.dart';
import 'package:dependencies/fpdart/fpdart.dart';

import '../../domain/entities/scan_result_entity.dart';
import '../../domain/repositories/fridge_scan_repository.dart';
import '../datasources/ai/fridge_ai_data_source.dart';
import '../datasources/remote/fridge_scan_remote_data_source.dart';
import '../models/ingredient_model.dart';
import '../mapper/scan_mapper.dart';
import '../models/scan_model.dart';

class FridgeScanRepositoryImpl implements FridgeScanRepository {
  FridgeScanRepositoryImpl(this._remoteDataSource, this._aiDataSource);

  final FridgeScanRemoteDataSource _remoteDataSource;
  final FridgeAiDataSource _aiDataSource;

  @override
  Future<Either<Failure, ScanResultEntity>> scanFridge(Uint8List bytes) async {
    try {
      // 1. Upload the image to storage and get a signed URL.
      final String imageUrl = await _remoteDataSource.uploadImage(bytes);

      // 2. Analyse the image with the AI backend.
      final AiAnalysisResult analysis = await _aiDataSource.analyzeImage(bytes);

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

      return Right<Failure, ScanResultEntity>(
        ScanResultEntity(
          scan: scan.toEntity(),
          ingredients: ingredients.map((IngredientModel model) => model.toEntity()).toList(),
        ),
      );
    } on AppException catch (e) {
      return Left<Failure, ScanResultEntity>(e.toFailure());
    }
  }
}
