import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

/// The app's main shell: a bottom navigation bar hosting the Scan, Recipes and
/// Profile tabs.
///
/// The shell is feature-agnostic — it only knows about the [StatefulNavigationShell]
/// handed to it by the router (built in the app layer from each feature's
/// routes). Switching tabs goes through [StatefulNavigationShell.goBranch], which
/// preserves each branch's own navigation state.
class DashboardShell extends StatelessWidget {
  const DashboardShell({
    required this.navigationShell,
    super.key,
  });

  /// Drives which branch is shown and exposes the current tab index.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onDestinationSelected(int index) {
    // Re-tapping the active tab resets it to that branch's initial route.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
