part of 'scan_bloc.dart';

@freezed
abstract class ScanEvent with _$ScanEvent {
  /// The user picked a capture source in the photo-source sheet. Resolves the
  /// required OS permission, then opens the camera or gallery.
  const factory ScanEvent.sourceSelected(ImageSourceOption source) = _SourceSelected;

  /// The user confirmed the previewed photo — start the AI scan.
  const factory ScanEvent.confirmed() = _ScanConfirmed;

  /// The user rejected the previewed photo and wants to capture another.
  const factory ScanEvent.retaken() = _ScanRetaken;

  /// Open the OS app settings so the user can grant a permanently denied
  /// permission.
  const factory ScanEvent.settingsRequested() = _SettingsRequested;

  /// Clear the scan back to its initial state.
  const factory ScanEvent.reset() = _ScanReset;
}
