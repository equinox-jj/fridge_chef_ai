import 'package:core/router/app_navigator.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Fridge Chef AI'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.read<AppNavigator>().toSignIn(),
              child: const Text('Get started'),
            ),
          ],
        ),
      ),
    );
  }
}
