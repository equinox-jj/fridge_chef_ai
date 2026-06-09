import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

/// Converts the data-layer [UserModel] into the domain [UserEntity].
extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      dietaryPreferences: dietaryPreferences,
      createdAt: createdAt,
    );
  }
}
