import '../../models/recipe_model.dart';
import '../../models/saved_recipe_model.dart';

/// Contract for the on-device cookbook cache (Drift).
///
/// Implementations throw a [CacheException] on failure; mapping to a
/// presentation-safe `Failure` is the repository's responsibility.
abstract class RecipeLocalDataSource {
  /// Returns the cached cookbook, newest first.
  Future<List<SavedRecipeModel>> getCookbook();

  /// Emits the cached cookbook (newest first) and re-emits whenever it changes,
  /// so the cookbook grid stays in sync in real time.
  Stream<List<SavedRecipeModel>> watchCookbook();

  /// Replaces the whole cached cookbook with [recipes] (the offline mirror of
  /// the backend, refreshed when online).
  Future<void> replaceCookbook(List<SavedRecipeModel> recipes);

  /// Inserts or updates a single cached entry — used to write a freshly saved
  /// recipe straight into the cache so it's there offline, immediately.
  Future<void> upsert(SavedRecipeModel recipe);

  /// Returns the cached full detail for the recipe [id], or `null` on a cache
  /// miss (it was never opened online).
  Future<RecipeModel?> getRecipeDetail({required String id});

  /// Stores the full [recipe] detail under [id] so it reads instantly — and
  /// offline — on later visits.
  Future<void> cacheRecipeDetail({
    required String id,
    required RecipeModel recipe,
  });
}
