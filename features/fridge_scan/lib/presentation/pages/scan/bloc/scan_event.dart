part of 'scan_bloc.dart';

@freezed
sealed class ScanEvent with _$ScanEvent {
  /// Dispatched after the user picks/captures an image from the FAB.
  const factory ScanEvent.confirmed(XFile file) = ScanConfirmed;

  /// Resets the bloc back to its initial state.
  const factory ScanEvent.reset() = ScanReset;
}
