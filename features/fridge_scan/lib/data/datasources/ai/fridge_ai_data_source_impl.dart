import 'dart:convert';
import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
// Firebase AI also exports a `ServerException`; hide it so the core domain
// exception is the one in scope here.
import 'package:dependencies/firebase/firebase_ai.dart' hide ServerException;

import '../../models/ingredient_model.dart';
import 'fridge_ai_data_source.dart';

class FridgeAiDataSourceImpl implements FridgeAiDataSource {
  FridgeAiDataSourceImpl({GenerativeModel? model})
    : _model =
          model ??
          FirebaseAI.googleAI().generativeModel(
            model: _modelName,
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
            ),
          );

  final GenerativeModel _model;

  static const String _modelName = 'gemini-2.5-flash';

  static const String _prompt = '''
You are a kitchen assistant. Look at this photo of the inside of a fridge and
identify every distinct food ingredient you can see.

Respond with ONLY a JSON array (no markdown, no commentary). Each element must
be an object with exactly these string fields:
- "name": the ingredient name, lowercase singular (e.g. "tomato")
- "quantity": the amount as a string (e.g. "2", "500"); use "" if unknown
- "unit": the unit for the quantity (e.g. "pcs", "g", "ml"); use "" if unknown
- "category": one of "produce", "dairy", "meat", "seafood", "beverage",
  "condiment", "grain", "frozen", "other"

If you can see no food, return an empty array [].
''';

  @override
  Future<AiAnalysisResult> analyzeImage(Uint8List imageBytes) async {
    final String raw;
    try {
      final GenerateContentResponse response = await _model.generateContent(
        <Content>[
          Content.multi(<Part>[
            TextPart(_prompt),
            InlineDataPart('image/jpeg', imageBytes),
          ]),
        ],
      );
      raw = response.text ?? '';
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to analyze the image: $e');
    }

    return AiAnalysisResult(
      ingredients: _parseIngredients(raw),
      rawResponse: raw,
    );
  }

  /// Parses the model's JSON array response into [IngredientModel]s.
  List<IngredientModel> _parseIngredients(String raw) {
    if (raw.trim().isEmpty) {
      throw const ServerException(
        'The AI returned an empty response. Please try again.',
      );
    }
    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw const FormatException('Expected a JSON array of ingredients.');
      }
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(IngredientModel.fromJson)
          .toList();
    } on FormatException catch (e) {
      throw ServerException('Could not read ingredients from the image: $e');
    }
  }
}
