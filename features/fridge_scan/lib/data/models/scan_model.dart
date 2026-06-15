import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import 'ingredient_model.dart';

part 'scan_model.freezed.dart';
part 'scan_model.g.dart';

/// A scan header paired with the ingredients detected in it — the data-layer
/// composite shared by the remote (nested `fridge_scans → ingredients` query)
/// and local (cached JSON payload) data sources.
typedef ScanWithIngredients = ({
  ScanModel scan,
  List<IngredientModel> ingredients,
});

@freezed
abstract class ScanModel with _$ScanModel {
  factory ScanModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'raw_ai_response') String? rawAiResponse,
    @JsonKey(name: 'scanned_at') DateTime? scannedAt,
  }) = _ScanModel;

  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      _$ScanModelFromJson(json);
}
