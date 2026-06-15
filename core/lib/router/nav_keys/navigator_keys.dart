import 'package:flutter/widgets.dart';

/// The app's root [Navigator] key, owned by `core` so the app router and the
/// feature route definitions can share a single instance.
///
/// Passed to `GoRouter(navigatorKey:)` and referenced by any route that sets
/// `$parentNavigatorKey` to present full-screen *above* the dashboard's
/// [StatefulShellRoute] — i.e. without the bottom navigation bar.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
