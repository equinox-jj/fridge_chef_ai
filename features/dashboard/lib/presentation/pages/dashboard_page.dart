import 'package:core/router/app_route.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => context.goNamed(AppRoute.fridgeScanName),
          icon: const Icon(Icons.camera_alt_outlined),
          label: const Text('Scan my fridge'),
        ),
      ),
    );
  }
}
