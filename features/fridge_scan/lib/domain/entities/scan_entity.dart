import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'scan_entity.freezed.dart';

@freezed
abstract class ScanEntity with _$ScanEntity {
  factory ScanEntity({
    String? id,
    String? userId,
    String? imageUrl,
    String? rawAiResponse,
    DateTime? scannedAt,
  }) = _ScanEntity;
}
