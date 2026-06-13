import '../../domain/entities/saved_recipe_entity.dart';
import '../models/saved_recipe_model.dart';

/// Maps the data-layer [SavedRecipeModel] to the domain [SavedRecipeEntity].
extension SavedRecipeModelMapper on SavedRecipeModel {
  SavedRecipeEntity toEntity() {
    return SavedRecipeEntity(
      id: id,
      title: title,
      cookTimeMinutes: cookTimeMinutes,
      mood: mood,
      rating: rating,
      savedAt: savedAt,
    );
  }
}
