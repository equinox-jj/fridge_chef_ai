/// The dashboard feature: the app's main bottom-navigation shell.
///
/// Unlike the other features, dashboard owns no routes of its own — it exposes
/// the [DashboardShell] widget that the app layer wires into a
/// `StatefulShellRoute` over the scan, recipes and profile branches.
library;

export 'presentation/pages/dashboard_shell.dart';
