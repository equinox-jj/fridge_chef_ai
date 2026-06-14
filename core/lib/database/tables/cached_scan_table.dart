import 'package:dependencies/drift/drift.dart';

/// On-device cache of the user's most recent fridge scans — the offline mirror
/// of the home screen's "Recent scans" list.
///
/// Holds just enough to render (and re-open) a past scan without a network
/// call, so the home screen still shows history offline. Each scan — its header
/// plus the ingredients detected in it — is stored as a JSON [payload] keyed by
/// the remote scan [id]: the whole row is read and written as one document and
/// never queried by its inner fields, so a single blob is simpler than
/// mirroring the backend's scan/ingredient tables. [scannedAt] is denormalised
/// out so the list can be ordered for display without decoding every payload.
class CachedScanRows extends Table {
  TextColumn get id => text()();
  TextColumn get payload => text()();
  DateTimeColumn get scannedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
