import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import 'ingredient_entity.dart';
import 'scan_entity.dart';

part 'scan_result_entity.freezed.dart';

/// The outcome of a completed fridge scan: the persisted scan header plus the
/// ingredients detected in it.
@freezed
abstract class ScanResultEntity with _$ScanResultEntity {
  factory ScanResultEntity({
    required ScanEntity scan,
    required List<IngredientEntity> ingredients,
  }) = _ScanResultEntity;
}
