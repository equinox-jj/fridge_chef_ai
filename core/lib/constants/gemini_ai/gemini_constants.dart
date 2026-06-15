abstract final class GeminiConstants {
  static const int signedUrlTtl = 60 * 60 * 24 * 365;
  static const String geminiModel = 'gemini-2.5-flash';
  static const int recipeCount = 3;
  static const String defaultDiet = 'none';
  static const String ingredientScanPrompt = '''
You are a kitchen assistant expert. First decide whether this photo actually
shows food, ingredients, or the inside of a fridge.

If it does NOT (e.g. a person, a room, a random object, a screenshot), set
"is_food" to false and return an empty "ingredients" array. Do not invent
ingredients.

If it does, set "is_food" to true and list every distinct food ingredient you
can see. For each ingredient:
- "name": the ingredient name, lowercase singular (e.g. "tomato").
- "quantity": your best estimate of the amount as a string — count the visible
  items where you can (e.g. "3"); use "" only when you truly cannot tell.
- "unit": the unit for that quantity — "pcs" for countable items, otherwise a
  sensible measure like "g" or "ml"; use "" when unknown.
- "category": the best-fitting category for the ingredient.
''';
}
