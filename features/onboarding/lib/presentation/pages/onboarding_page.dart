import 'package:core/router/app_route.dart';
import 'package:dependencies/go_router/go_router.dart';
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
              // Cross-feature navigation by name keeps onboarding decoupled
              // from the auth package.
              onPressed: () => context.goNamed(AppRoute.signInName),
              child: const Text('Get started'),
            ),
          ],
        ),
      ),
    );
  }
}
