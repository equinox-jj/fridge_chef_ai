import '../../domain/entities/ingredient_entity.dart';
import '../../domain/entities/scan_entity.dart';
import '../models/ingredient_model.dart';
import '../models/scan_model.dart';

/// Maps the data-layer [ScanModel] to the domain [ScanEntity].
extension ScanModelMapper on ScanModel {
  ScanEntity toEntity() {
    return ScanEntity(
      id: id,
      userId: userId,
      imageUrl: imageUrl,
      rawAiResponse: rawAiResponse,
      scannedAt: scannedAt,
    );
  }
}

/// Maps the data-layer [IngredientModel] to the domain [IngredientEntity].
extension IngredientModelMapper on IngredientModel {
  IngredientEntity toEntity() {
    return IngredientEntity(
      id: id,
      scanId: scanId,
      name: name,
      quantity: quantity,
      unit: unit,
      category: category,
    );
  }
}
