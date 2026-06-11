import 'package:flutter/material.dart';

import '../../widgets/pick_image_source_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.camera_alt_rounded),
        onPressed: () => PickImageSourceSheet.openSheet(
          context,
        ),
      ),
      body: const Center(child: Text('Home')),
    );
  }
}
