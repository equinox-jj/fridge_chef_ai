/// The dietary preferences recipes can be constrained to (PRD §4.3.1).
///
/// [value] is the token stored on the user row and injected into the prompt;
/// [label] is what the mood screen shows. [none] means "no restriction".
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
