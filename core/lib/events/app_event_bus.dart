import 'dart:async';

/// Base type for app-wide domain events broadcast on [AppEventBus]. Sealed so
/// subscribers can switch exhaustively over the known events.
sealed class AppEvent {
  const AppEvent();
}

/// A new fridge scan was persisted. The Home tab listens for this to resync its
/// recent-scans list.
class ScanCreated extends AppEvent {
  const ScanCreated();
}

/// A recipe was saved to the cookbook. The Recipes tab listens for this to
/// resync its cookbook grid.
class RecipeSaved extends AppEvent {
  const RecipeSaved();
}

/// A lightweight, app-wide publish/subscribe seam for cross-feature domain
/// events. Registered as a single instance in DI and injected where needed —
/// never accessed as a static global, so it stays fakeable in tests.
///
/// Backed by a broadcast stream: multiple blocs can subscribe, and publishing
/// with no subscribers is a no-op.
class AppEventBus {
  final StreamController<AppEvent> _controller =
      StreamController<AppEvent>.broadcast();

  /// The stream of published events. Subscribers must cancel their
  /// subscriptions when disposed.
  Stream<AppEvent> get stream => _controller.stream;

  /// Publishes [event] to all current subscribers. Safe to call after
  /// [dispose] (becomes a no-op).
  void publish(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Closes the underlying stream. Called by DI on teardown.
  Future<void> dispose() => _controller.close();
}
