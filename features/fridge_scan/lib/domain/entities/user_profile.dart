import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// The signed-in user's profile, as the home screen needs it.
///
/// Owned by fridge-scan (not imported from `auth`) so the feature stays
/// decoupled; the composition root maps the auth user onto this model.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) = _UserProfile;
}
