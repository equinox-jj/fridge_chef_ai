import 'package:dependencies/drift/drift.dart';

/// On-device cache of a saved recipe's *full* detail — its header plus the
/// steps and ingredients needed to render the recipe screen offline (PRD §4.4).
///
/// The cookbook grid only needs the lightweight summary ([SavedRecipeRows]);
/// this fills in the rest the first time a recipe is opened online, so the same
/// recipe reads instantly — and works offline — on every later visit. The whole
/// recipe is stored as a JSON [payload] keyed by the remote recipe [id]: it's
/// read and written as one document, never queried by its inner fields, so a
/// single blob is simpler than mirroring the backend's three tables.
class RecipeDetailRows extends Table {
  TextColumn get id => text()();
  TextColumn get payload => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
