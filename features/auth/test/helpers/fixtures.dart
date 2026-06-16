import 'package:auth/data/models/user_model.dart';
import 'package:auth/domain/entities/user_entity.dart';

/// Shared test data builders. Defaults are sensible; override only the fields a
/// given test cares about.
final DateTime tCreatedAt = DateTime.utc(2026, 1, 2, 3, 4, 5);

UserModel userModel({
  String? id = 'u1',
  String? name = 'Ada',
  String? email = 'ada@example.com',
  String? avatarUrl = 'https://example.com/a.png',
  String? dietaryPreferences = 'vegan',
  DateTime? createdAt,
}) {
  return UserModel(
    id: id,
    name: name,
    email: email,
    avatarUrl: avatarUrl,
    dietaryPreferences: dietaryPreferences,
    createdAt: createdAt ?? tCreatedAt,
  );
}

UserEntity userEntity({
  String? id = 'u1',
  String? name = 'Ada',
  String? email = 'ada@example.com',
  String? avatarUrl = 'https://example.com/a.png',
  String? dietaryPreferences = 'vegan',
  DateTime? createdAt,
}) {
  return UserEntity(
    id: id,
    name: name,
    email: email,
    avatarUrl: avatarUrl,
    dietaryPreferences: dietaryPreferences,
    createdAt: createdAt ?? tCreatedAt,
  );
}

/// A `users` row as Supabase returns it.
Map<String, dynamic> userRow({
  String id = 'u1',
  String name = 'Ada',
  String email = 'ada@example.com',
  String? avatarUrl = 'https://example.com/a.png',
  String? dietaryPreference = 'vegan',
  String createdAt = '2026-01-02T03:04:05.000Z',
}) {
  return <String, dynamic>{
    'id': id,
    'name': name,
    'email': email,
    'avatar_url': avatarUrl,
    'dietary_preference': dietaryPreference,
    'created_at': createdAt,
  };
}
