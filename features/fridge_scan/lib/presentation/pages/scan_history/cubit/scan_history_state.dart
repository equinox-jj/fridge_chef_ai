part of 'scan_history_cubit.dart';

@freezed
abstract class ScanHistoryState with _$ScanHistoryState {
  const factory ScanHistoryState({
    @Default(<ScanResultEntity>[]) List<ScanResultEntity> scans,
    @Default(BlocStatus.initial) BlocStatus status,
  }) = _ScanHistoryState;
}
