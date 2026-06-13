import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

/// The signed-in user's profile as the Profile screen needs it.
///
/// [dietaryPreference] is the raw token stored on the user row (e.g. `vegan`);
/// the presentation layer resolves it to a label via `DietaryPreference`.
@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    String? name,
    String? email,
    String? avatarUrl,
    String? dietaryPreference,
  }) = _ProfileEntity;
}
