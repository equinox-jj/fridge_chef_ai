import 'package:flutter/material.dart';

import '../recipe_mood.dart';
import 'recipe_photo_placeholder.dart';

/// A recipe banner backed by a curated, mood-specific asset.
///
/// Each [RecipeMood] maps to one bundled photo ([RecipeMood.imageAsset]); if
/// that asset is missing or fails to decode, it falls back to the neutral
/// [RecipePhotoPlaceholder] so a card or detail header never renders blank.
class RecipePhoto extends StatelessWidget {
  const RecipePhoto({
    required this.mood,
    required this.height,
    super.key,
  });

  final RecipeMood mood;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      mood.imageAsset,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
          RecipePhotoPlaceholder(height: height),
    );
  }
}
