import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  factory UserEntity({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? dietaryPreferences,
    DateTime? createdAt,
  }) = _UserEntity;
}
