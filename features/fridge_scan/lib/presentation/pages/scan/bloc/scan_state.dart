part of 'scan_bloc.dart';

@freezed
sealed class ScanState with _$ScanState {
  /// Nothing scanned yet.
  const factory ScanState.initial() = ScanInitial;

  /// The scan pipeline (upload → AI → persist) is running.
  const factory ScanState.loading() = ScanLoading;

  /// Scan completed: the persisted header plus detected ingredients.
  const factory ScanState.done(
    ScanEntity scan,
    List<IngredientEntity> ingredients,
  ) = ScanDone;

  /// The scan failed.
  const factory ScanState.error(Failure failure) = ScanError;
}
