import 'package:dependencies/drift/drift.dart';

/// On-device cache of the user's cookbook — the recipes they've saved.
///
/// Holds just enough to render the cookbook grid (PRD §4.4) without a network
/// call, so saved recipes (and the screen) keep working offline. The full
/// recipe lives remotely; this is the offline-readable summary, keyed by the
/// remote recipe [id] and ordered for display by [savedAt].
class SavedRecipeRows extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get cookTimeMinutes => integer().nullable()();
  TextColumn get mood => text().nullable()();
  IntColumn get rating => integer().withDefault(const Constant<int>(0))();
  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
