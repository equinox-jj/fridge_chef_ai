/// Cross-feature hand-off payload for the recipe-generation flow.
///
/// Lives in `core` (alongside [AppNavigator]/[AppRoute]) so the `fridge_scan`
/// feature can launch the `recipes` flow without importing it: the ingredient
/// review maps its detected ingredients onto these plain seed values, and the
/// recipes feature reads them back as a `$extra` argument. Keeping the contract
/// here is the seam that lets the two feature packages stay decoupled.
class RecipeGenerationArgs {
  const RecipeGenerationArgs({
    required this.ingredients,
    this.scanId,
  });

  /// The (possibly edited) ingredients the recipes should be built from.
  final List<RecipeSeedIngredient> ingredients;

  /// The originating scan, so a saved recipe can be linked back to it. Null
  /// when the flow is started without a backing scan.
  final String? scanId;
}

/// A single ingredient passed into recipe generation — just enough for the
/// Gemini prompt, decoupled from any feature's own ingredient model.
class RecipeSeedIngredient {
  const RecipeSeedIngredient({
    required this.name,
    this.quantity,
    this.unit,
  });

  final String name;
  final String? quantity;
  final String? unit;
}
