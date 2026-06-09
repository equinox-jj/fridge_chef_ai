import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'scan_model.freezed.dart';
part 'scan_model.g.dart';

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
