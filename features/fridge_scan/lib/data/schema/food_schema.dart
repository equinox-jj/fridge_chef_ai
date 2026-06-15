import 'package:core/constants/gemini_ai/ingredient_categories.dart';
import 'package:dependencies/firebase/firebase_ai.dart';

abstract final class FoodSchema {
  static final Schema responseSchema = Schema.object(
    properties: <String, Schema>{
      'is_food': Schema.boolean(
        description:
            'True only if the photo shows food, ingredients, or the inside of '
            'a fridge. False for anything else (people, rooms, objects, '
            'screenshots, etc.).',
      ),
      'ingredients': Schema.array(
        items: Schema.object(
          properties: <String, Schema>{
            'name': Schema.string(
              description:
                  'Ingredient name, lowercase singular (e.g. "tomato").',
            ),
            'quantity': Schema.string(
              description:
                  'Best-effort amount as a string (e.g. "2", "500"); '
                  'use "" only when it truly cannot be told.',
            ),
            'unit': Schema.string(
              description:
                  'Unit for the quantity ("pcs" for countable items, else '
                  '"g", "ml", etc.); use "" when unknown.',
            ),
            'category': Schema.enumString(
              enumValues: IngredientCategories.getDisplayNames(),
            ),
          },
        ),
      ),
    },
  );
}
