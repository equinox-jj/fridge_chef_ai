import 'dart:typed_data';

import '../../models/ingredient_model.dart';

/// Outcome of an AI image analysis: the parsed ingredients plus the raw model
/// response (persisted on the scan header for auditing/debugging).
class AiAnalysisResult {
  const AiAnalysisResult({
    required this.ingredients,
    required this.rawResponse,
  });

  final List<IngredientModel> ingredients;
  final String rawResponse;
}

/// Contract for the AI vision backend (Firebase AI) that detects ingredients
/// from a fridge photo. Throws an [AppException] on failure.
abstract class FridgeAiDataSource {
  Future<AiAnalysisResult> analyzeImage(Uint8List imageBytes);
}
