import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => context.read<AppNavigator>().toFridgeScan(),
          icon: const Icon(Icons.camera_alt_outlined),
          label: const Text('Scan my fridge'),
        ),
      ),
    );
  }
}
