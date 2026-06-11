part of 'scan_bloc.dart';

@freezed
abstract class ScanEvent with _$ScanEvent {
  const factory ScanEvent.confirmed(XFile file) = _ScanConfirmed;
  const factory ScanEvent.reset() = _ScanReset;
}
