part of 'connectivity_bloc.dart';

@freezed
abstract class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState({
    /// `true` when the device has a network path. Starts optimistically online
    /// until the first verdict from [ConnectivityService] lands.
    @Default(true) bool isOnline,
  }) = _ConnectivityState;

  const ConnectivityState._();

  /// Convenience inverse for offline-driven UI (banners, disabled actions).
  bool get isOffline => !isOnline;
}
