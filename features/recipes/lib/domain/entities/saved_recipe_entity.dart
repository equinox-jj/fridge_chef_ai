import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'saved_recipe_entity.freezed.dart';

/// A single entry in the user's cookbook: the offline-readable summary of a
/// saved recipe, just enough to render its grid card (PRD §4.4).
///
/// [id] is the saved recipe's remote id. [mood] drives the card's banner photo;
/// [rating] is the 1–5 the user gave it on save. The full recipe (steps,
/// ingredients) is fetched on demand — the cookbook itself stays light so it
/// loads from the on-device cache without a network call.
@freezed
abstract class SavedRecipeEntity with _$SavedRecipeEntity {
  factory SavedRecipeEntity({
    required String id,
    required String title,
    required DateTime savedAt,
    int? cookTimeMinutes,
    String? mood,
    @Default(0) int rating,
  }) = _SavedRecipeEntity;
}
