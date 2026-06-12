part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  /// Initial load: greeting profile + recent scans.
  const factory HomeEvent.started() = _Started;

  /// Re-fetch the recent scans list (e.g. after a new scan completes).
  const factory HomeEvent.refreshed() = _Refreshed;
}
