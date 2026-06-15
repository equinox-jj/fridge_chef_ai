enum IngredientCategories {
  produce('produce'),
  dairy('dairy'),
  meat('meat'),
  seafood('seafood'),
  beverage('beverage'),
  condiment('condiment'),
  grain('grain'),
  frozen('frozen'),
  other('other');

  const IngredientCategories(this.displayName);

  final String displayName;

  static List<String> getDisplayNames() {
    return IngredientCategories.values
        .map(
          (IngredientCategories e) => e.displayName,
        )
        .toList();
  }
}
