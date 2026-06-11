import 'dart:typed_data';

import 'package:core/constants/exceptions/app_exceptions.dart';
import 'package:core/constants/supabase_table/supabase_table.dart';
import 'package:core/services/supabase_service.dart';
import 'package:dependencies/supabase_flutter/supabase_flutter.dart';

import '../../models/ingredient_model.dart';
import '../../models/scan_model.dart';
import 'fridge_scan_remote_data_source.dart';

class FridgeScanRemoteDataSourceImpl implements FridgeScanRemoteDataSource {
  FridgeScanRemoteDataSourceImpl(this._supabaseService);

  final SupabaseService _supabaseService;

  static const String _bucket = 'fridge_scans';

  /// Signed-URL lifetime: one year, in seconds.
  static const int _signedUrlTtl = 60 * 60 * 24 * 365;

  SupabaseClient get _client => _supabaseService.client;

  @override
  Future<String> uploadImage(Uint8List bytes) {
    return _supabaseService.safeCall(() async {
      final String userId = _requireUserId();
      final String path = '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _client.storage
          .from(_bucket)
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );
      return _client.storage.from(_bucket).createSignedUrl(path, _signedUrlTtl);
    });
  }

  @override
  Future<ScanModel> insertScan({
    required String imageUrl,
    required String rawAiResponse,
  }) {
    return _supabaseService.safeCall(() async {
      final Map<String, dynamic> inserted = await _client
          .from(SupabaseTable.fridgeScansTable)
          .insert(<String, dynamic>{
            'user_id': _requireUserId(),
            'image_url': imageUrl,
            'raw_ai_response': rawAiResponse,
          })
          .select()
          .single();
      return ScanModel.fromJson(inserted);
    });
  }

  @override
  Future<List<IngredientModel>> insertIngredients({
    required String scanId,
    required List<IngredientModel> items,
  }) {
    return _supabaseService.safeCall(() async {
      if (items.isEmpty) {
        return <IngredientModel>[];
      }
      final List<Map<String, dynamic>> rows = items
          .map(
            (IngredientModel item) => <String, dynamic>{
              'scan_id': scanId,
              'name': item.name,
              'quantity': item.quantity,
              'unit': item.unit,
              'category': item.category,
            },
          )
          .toList();
      final List<Map<String, dynamic>> inserted = await _client
          .from(SupabaseTable.ingredientsTable)
          .insert(rows)
          .select();
      return inserted.map(IngredientModel.fromJson).toList();
    });
  }

  /// Returns the current user id, or throws when there is no active session.
  String _requireUserId() {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw const InvalidCredentialsException(
        'You must be signed in to scan your fridge.',
      );
    }
    return user.id;
  }
}
