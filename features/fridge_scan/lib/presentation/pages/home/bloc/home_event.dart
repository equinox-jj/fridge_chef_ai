part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  /// Initial load: watch the profile + recent scans, and kick a backend sync.
  const factory HomeEvent.started() = _Started;

  /// Trigger a backend resync of recent scans (initial load, pull-to-refresh,
  /// or a new scan announced on the event bus). The watch stream delivers the
  /// resulting data.
  const factory HomeEvent.synced() = _Synced;
}
