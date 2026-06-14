import 'dart:typed_data';

import '../../models/ingredient_model.dart';
import '../../models/scan_model.dart';

/// Contract for the Supabase-backed persistence of a fridge scan: image upload,
/// scan-header insert, and batch ingredient insert. Throws an [AppException] on
/// failure.
abstract class FridgeScanRemoteDataSource {
  /// Uploads [bytes] to the `fridge_scans` storage bucket and returns a signed
  /// URL to the stored object.
  Future<String> uploadImage(Uint8List bytes);

  /// Inserts the scan header row and returns the persisted model (with id).
  Future<ScanModel> insertScan({
    required String imageUrl,
    required String rawAiResponse,
  });

  /// Batch-inserts one ingredient row per [items] entry, linked to [scanId],
  /// and returns the persisted rows.
  Future<List<IngredientModel>> insertIngredients({
    required String scanId,
    required List<IngredientModel> items,
  });

  /// Fetches the signed-in user's most recent scans (newest first), each paired
  /// with its detected ingredients, capped at [limit] rows.
  Future<List<ScanWithIngredients>> getRecentScans({required int limit});
}
