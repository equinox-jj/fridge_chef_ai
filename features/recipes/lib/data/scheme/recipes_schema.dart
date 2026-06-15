import 'package:dependencies/firebase/firebase_ai.dart';

abstract final class RecipesSchema {
  static final Schema responseSchema = Schema.object(
    properties: <String, Schema>{
      'recipes': Schema.array(
        items: Schema.object(
          properties: <String, Schema>{
            'title': Schema.string(
              description: 'Short, appetising recipe name.',
            ),
            'description': Schema.string(
              description: 'One-sentence description of the dish.',
            ),
            'servings': Schema.integer(
              description: 'How many people it serves.',
            ),
            'cook_time_minutes': Schema.integer(
              description: 'Total cook time in minutes.',
            ),
            'ingredients': Schema.array(
              items: Schema.object(
                properties: <String, Schema>{
                  'name': Schema.string(description: 'Ingredient name.'),
                  'quantity': Schema.string(
                    description:
                        'Amount, e.g. "1", "250"; "" if not applicable.',
                  ),
                  'unit': Schema.string(
                    description:
                        'Unit, e.g. "g", "ml", "cup", "can"; "" if none.',
                  ),
                  'is_substitute': Schema.boolean(
                    description:
                        'True when this ingredient replaces one the user does not have.',
                  ),
                },
              ),
            ),
            'steps': Schema.array(
              items: Schema.object(
                properties: <String, Schema>{
                  'step_number': Schema.integer(
                    description: 'Order of the step, starting at 1.',
                  ),
                  'instruction': Schema.string(
                    description: 'What to do in this step.',
                  ),
                  'timer_seconds': Schema.integer(
                    description:
                        'Seconds for a timed step (e.g. "simmer 10 min" = 600); 0 if untimed.',
                  ),
                },
              ),
            ),
          },
        ),
      ),
    },
  );
}
