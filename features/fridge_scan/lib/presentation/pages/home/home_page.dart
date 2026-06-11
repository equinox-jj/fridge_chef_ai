import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.camera_alt_rounded),
        onPressed: () => context.read<AppNavigator>().toFridgeScan(),
      ),
      body: const Center(child: Text('Home')),
    );
  }
}
