part of 'cookbook_bloc.dart';

@freezed
abstract class CookbookEvent with _$CookbookEvent {
  /// First load: seed connectivity, subscribe to changes, read the cookbook.
  const factory CookbookEvent.started() = _Started;

  /// Re-read the cookbook (e.g. pull-to-refresh, returning to the tab).
  const factory CookbookEvent.refreshed() = _Refreshed;
}
