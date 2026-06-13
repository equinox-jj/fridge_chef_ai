import 'package:dependencies/connectivity_plus/connectivity_plus.dart';

/// Reports whether the device currently has a network path, and emits whenever
/// that changes.
///
/// Declared in `core` as an abstraction so features depend on the *capability*,
/// not on `connectivity_plus` — which keeps call sites (and tests) free to
/// drive online/offline with a fake. The offline state is treated as a
/// first-class capability across the app (a cached cookbook still works), so
/// this lives next to the other shared services rather than inside any feature.
abstract interface class ConnectivityService {
  /// `true` when at least one network interface is available.
  ///
  /// This reflects a network *path*, not guaranteed reachability — enough to
  /// drive the offline banner and gate network-only actions (e.g. scanning).
  Future<bool> get isOnline;

  /// Emits the online state on every connectivity change (true = online).
  ///
  /// Distinct values only: subscribers are not re-notified for transitions
  /// that don't flip the online/offline verdict (e.g. wifi → mobile).
  Stream<bool> get onStatusChanged;
}

class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl([Connectivity? connectivity]) : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get isOnline async => _isOnline(await _connectivity.checkConnectivity());

  @override
  Stream<bool> get onStatusChanged => _connectivity.onConnectivityChanged.map(_isOnline).distinct();

  /// A device is online when any reported interface is something other than
  /// [ConnectivityResult.none].
  bool _isOnline(List<ConnectivityResult> results) =>
      results.any((ConnectivityResult r) => r != ConnectivityResult.none);
}
