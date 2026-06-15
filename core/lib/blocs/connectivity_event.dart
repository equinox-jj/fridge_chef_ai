part of 'connectivity_bloc.dart';

@freezed
abstract class ConnectivityEvent with _$ConnectivityEvent {
  /// Seeds the current verdict and starts forwarding changes. Dispatched once
  /// when the bloc is created.
  const factory ConnectivityEvent.started() = _Started;

  /// The device's online state flipped (from the service stream).
  const factory ConnectivityEvent.statusChanged({required bool isOnline}) =
      _StatusChanged;
}
