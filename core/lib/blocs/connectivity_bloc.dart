import 'dart:async';

import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../services/connectivity_service.dart';

part 'connectivity_bloc.freezed.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

/// The app-wide source of truth for the device's online/offline state.
///
/// Wraps [ConnectivityService] in a single, globally-provided bloc so every
/// part of the app observes connectivity from one place — by listening to this
/// bloc's [stream] or reading its current [state] — rather than each feature
/// holding its own raw [ConnectivityService] subscription. Provided once above
/// the router (`BlocProvider.value`) so any page reads it with
/// `context.watch<ConnectivityBloc>()`.
///
/// State starts optimistically online, seeds the real verdict from
/// [ConnectivityService] on creation ([ConnectivityEvent.started]), then emits
/// on every flip ([ConnectivityEvent.statusChanged]). [ConnectivityService]
/// stays the source of truth for one-off point-in-time queries; this bloc fans
/// *changes* out as a typed [ConnectivityState].
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this._connectivity) : super(const ConnectivityState()) {
    on<_Started>(_onStarted);
    on<_StatusChanged>(_onStatusChanged);
    // Seed + subscribe eagerly so consumers never have to kick off tracking.
    add(const ConnectivityEvent.started());
  }

  final ConnectivityService _connectivity;
  StreamSubscription<bool>? _subscription;

  /// Seeds the current verdict, then forwards every subsequent change as a
  /// [ConnectivityEvent.statusChanged].
  Future<void> _onStarted(
    _Started event,
    Emitter<ConnectivityState> emit,
  ) async {
    final bool isOnline = await _connectivity.isOnline;

    emit(
      state.copyWith(
        isOnline: isOnline,
      ),
    );

    _subscription ??= _connectivity.onStatusChanged.listen(
      (bool isOnline) => add(
        ConnectivityEvent.statusChanged(isOnline: isOnline),
      ),
    );
  }

  void _onStatusChanged(
    _StatusChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    emit(
      state.copyWith(
        isOnline: event.isOnline,
      ),
    );
  }

  /// Cancels the held connectivity subscription before tearing the bloc down.
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
