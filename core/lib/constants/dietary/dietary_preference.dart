/// The dietary preferences recipes can be constrained to (PRD §4.3.1).
///
/// [value] is the token stored on the user row and injected into the prompt;
/// [label] is what the UI shows. [none] means "no restriction".
///
/// Lives in `core` because it is shared across features: `recipes` reads it to
/// pre-fill the mood screen and seed the prompt, and `profile` lets the user
/// edit it from the dietary-preference sheet.
enum DietaryPreference {
  none('none', 'None'),
  vegetarian('vegetarian', 'Vegetarian'),
  vegan('vegan', 'Vegan'),
  halal('halal', 'Halal'),
  kosher('kosher', 'Kosher'),
  glutenFree('gluten-free', 'Gluten-free');

  const DietaryPreference(this.value, this.label);

  final String value;
  final String label;

  /// Resolves a raw [value] to its preference, falling back to [none].
  static DietaryPreference fromValue(String? value) {
    return DietaryPreference.values.firstWhere(
      (DietaryPreference d) => d.value == value,
      orElse: () => DietaryPreference.none,
    );
  }
}
