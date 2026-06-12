import 'package:flutter/material.dart';

/// Presentation metadata for the ingredient categories the AI may return.
///
/// The category *values* are owned by the data layer (they must satisfy the
/// `ingredients_category_check` DB constraint); this enum only adds the
/// display label and glyph used to group and decorate ingredients on screen.
/// Kept in the feature because it is specific to the fridge-scan ingredient
/// domain — promote to `core` only if another feature needs the same mapping.
enum IngredientCategory {
  produce('produce', 'Produce', Icons.eco_rounded),
  dairy('dairy', 'Dairy', Icons.egg_alt_rounded),
  meat('meat', 'Meat', Icons.kebab_dining_rounded),
  seafood('seafood', 'Seafood', Icons.set_meal_rounded),
  grain('grain', 'Grains', Icons.grain_rounded),
  condiment('condiment', 'Condiments', Icons.water_drop_rounded),
  beverage('beverage', 'Beverages', Icons.local_cafe_rounded),
  frozen('frozen', 'Frozen', Icons.ac_unit_rounded),
  other('other', 'Other', Icons.category_rounded);

  const IngredientCategory(this.value, this.label, this.icon);

  /// The raw value stored in the database / returned by the model.
  final String value;

  /// Human-readable section title.
  final String label;

  /// Glyph shown on the ingredient's icon tile.
  final IconData icon;

  /// Resolves a raw category [value] to its metadata, falling back to [other]
  /// for anything unrecognised (so a stray value never breaks the UI).
  static IngredientCategory fromValue(String? value) {
    return IngredientCategory.values.firstWhere(
      (IngredientCategory c) => c.value == value,
      orElse: () => IngredientCategory.other,
    );
  }
}
