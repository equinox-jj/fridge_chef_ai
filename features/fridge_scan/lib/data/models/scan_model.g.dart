// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanModel _$ScanModelFromJson(Map<String, dynamic> json) => _ScanModel(
  id: json['id'] as String?,
  userId: json['user_id'] as String?,
  imageUrl: json['image_url'] as String?,
  rawAiResponse: json['raw_ai_response'] as String?,
  scannedAt: json['scanned_at'] == null ? null : DateTime.parse(json['scanned_at'] as String),
);

Map<String, dynamic> _$ScanModelToJson(_ScanModel instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'image_url': instance.imageUrl,
  'raw_ai_response': instance.rawAiResponse,
  'scanned_at': instance.scannedAt?.toIso8601String(),
};
