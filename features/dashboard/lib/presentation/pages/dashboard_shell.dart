import 'package:core/theme/app_colors.dart';
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
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              color: AppColors.primaryActive,
            ),
            label: 'Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(
              Icons.menu_book,
              color: AppColors.primaryActive,
            ),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(
              Icons.person_rounded,
              color: AppColors.primaryActive,
            ),
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
