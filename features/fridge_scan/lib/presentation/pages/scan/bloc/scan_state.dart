part of 'scan_bloc.dart';

/// Where the user is in acquiring a photo, before the AI scan begins.
enum ScanPickStatus {
  /// No photo selected yet — show the prompt / empty state.
  idle,

  /// Resolving a permission or waiting on the OS picker.
  picking,

  /// A photo is selected and awaiting the user's confirmation.
  ready,

  /// A required permission was denied, so no photo could be captured. The
  /// accompanying [ScanState.permission] says whether app settings are needed.
  permissionDenied,
}

@freezed
abstract class ScanState with _$ScanState {
  const factory ScanState({
    /// Stage of the capture/preview flow.
    @Default(ScanPickStatus.idle) ScanPickStatus pickStatus,

    /// The photo awaiting confirmation, once one has been captured.
    XFile? pickedImage,

    /// Outcome of the last permission request, set when it was not granted.
    PermissionResult? permission,

    /// Lifecycle of the AI scan triggered on confirmation.
    @Default(BlocStatus.initial) BlocStatus scanState,
    Failure? scanFailure,
    ScanEntity? scanResponse,
    List<IngredientEntity>? ingredientsResponse,
  }) = ScanInitial;
}
