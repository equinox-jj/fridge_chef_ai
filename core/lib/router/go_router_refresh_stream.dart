import 'dart:async';

import 'package:flutter/foundation.dart';

/// A [ChangeNotifier] that re-notifies whenever [stream] emits an event.
///
/// Wire it into `GoRouter.refreshListenable` so the router re-evaluates its
/// `redirect` every time the source stream fires — for example the Supabase
/// auth-state stream, so sign-in / sign-out instantly reroutes the user.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
