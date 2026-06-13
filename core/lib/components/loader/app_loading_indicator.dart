import 'package:flutter/material.dart';

/// A centered [CircularProgressIndicator] for full-area loading states.
///
/// Pure UI — replaces the inline `Center(child: CircularProgressIndicator())`
/// repeated across feature pages.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
