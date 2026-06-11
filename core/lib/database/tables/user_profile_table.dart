import 'package:dependencies/drift/drift.dart';

/// Local cache of the signed-in user's profile.
///
/// Holds at most one row — the current user — kept in sync with the remote
/// `users` table by the auth feature's local data source.
class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get dietaryPreferences => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
