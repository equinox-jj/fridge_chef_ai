import 'dart:typed_data';

import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/image_source_option/image_source_option.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/extensions/image_source_ext.dart';
import 'package:core/services/image_picker_service.dart';
import 'package:core/services/permission_service.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';
import 'package:dependencies/image_picker/image_picker.dart';
import 'package:dependencies/permission_handler/permission_handler.dart';

import '../../../../domain/entities/profile_entity.dart';
import '../../../../domain/usecases/get_profile_usecase.dart';
import '../../../../domain/usecases/get_scan_count_usecase.dart';
import '../../../../domain/usecases/remove_avatar_usecase.dart';
import '../../../../domain/usecases/sign_out_usecase.dart';
import '../../../../domain/usecases/update_avatar_usecase.dart';
import '../../../../domain/usecases/update_dietary_preference_usecase.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._getProfile,
    this._getScanCount,
    this._updateDietaryPreference,
    this._signOut,
    this._updateAvatar,
    this._removeAvatar,
    this._permissionService,
    this._imagePicker,
  ) : super(const ProfileState());

  final GetProfileUseCase _getProfile;
  final GetScanCountUseCase _getScanCount;
  final UpdateDietaryPreferenceUseCase _updateDietaryPreference;
  final SignOutUseCase _signOut;
  final UpdateAvatarUseCase _updateAvatar;
  final RemoveAvatarUseCase _removeAvatar;
  final PermissionService _permissionService;
  final ImagePickerService _imagePicker;

  /// Loads the profile header (required) and the scan count (best-effort) in
  /// parallel.
  Future<void> load() async {
    emit(state.copyWith(loadStatus: BlocStatus.loading));
    await Future.wait(<Future<void>>[
      _loadProfile(),
      _loadScanCount(),
    ]);
  }

  Future<void> _loadProfile() async {
    final Either<Failure, ProfileEntity?> result = await _getProfile(const NoParams());
    if (isClosed) return;
    emit(
      result.fold(
        (Failure _) => state.copyWith(loadStatus: BlocStatus.error),
        (ProfileEntity? profile) => state.copyWith(
          profile: profile,
          loadStatus: BlocStatus.success,
        ),
      ),
    );
  }

  /// A missing count must not break the screen, so a failure is swallowed and
  /// the row simply renders without a number.
  Future<void> _loadScanCount() async {
    final Either<Failure, int> result = await _getScanCount(const NoParams());
    if (isClosed) return;
    result.fold(
      (Failure _) {},
      (int count) => emit(state.copyWith(scanCount: count)),
    );
  }

  Future<void> updateDietaryPreference(DietaryPreference preference) async {
    emit(state.copyWith(dietaryStatus: BlocStatus.loading));

    final Either<Failure, Unit> result = await _updateDietaryPreference(preference.value);

    if (isClosed) return;

    emit(
      result.fold(
        (Failure l) => state.copyWith(
          dietaryStatus: BlocStatus.error,
          dietaryFailure: l,
        ),
        (_) => state.copyWith(
          dietaryStatus: BlocStatus.success,
          // Reflect the saved choice immediately on the profile row.
          profile: (state.profile ?? const ProfileEntity()).copyWith(
            dietaryPreference: preference.value,
          ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(signOutStatus: BlocStatus.loading));

    final Either<Failure, Unit> result = await _signOut(const NoParams());

    if (isClosed) return;

    emit(
      result.fold(
        (Failure l) => state.copyWith(
          signOutStatus: BlocStatus.error,
          signOutFailure: l,
        ),
        (_) => state.copyWith(signOutStatus: BlocStatus.success),
      ),
    );
  }

  /// Picks a photo from [source] (resolving the camera permission first when
  /// needed), uploads it, and reflects the new URL on the profile header.
  Future<void> changeAvatar(ImageSourceOption source) async {
    emit(state.copyWith(avatarStatus: BlocStatus.loading, avatarFailure: null));

    // Camera needs a runtime grant; the gallery's system picker doesn't.
    final Permission? required = source.permission;
    if (required != null) {
      final PermissionResult permission = await _permissionService.ensure(required);
      if (isClosed) return;
      if (!permission.isGranted) {
        emit(
          state.copyWith(
            avatarStatus: BlocStatus.error,
            avatarFailure: const PermissionFailure(),
          ),
        );
        return;
      }
    }

    final XFile? image = await _imagePicker.pickImage(source.imageSource);
    if (isClosed) return;
    if (image == null) {
      // The user backed out of the picker — nothing changed.
      emit(state.copyWith(avatarStatus: BlocStatus.initial));
      return;
    }

    final Uint8List bytes = await image.readAsBytes();
    final Either<Failure, String> result = await _updateAvatar(bytes);
    if (isClosed) return;
    emit(
      result.fold(
        (Failure l) => state.copyWith(
          avatarStatus: BlocStatus.error,
          avatarFailure: l,
        ),
        (String url) => state.copyWith(
          avatarStatus: BlocStatus.success,
          profile: (state.profile ?? const ProfileEntity()).copyWith(avatarUrl: url),
        ),
      ),
    );
  }

  /// Clears the user's avatar, reverting the header to their initial.
  Future<void> removeAvatar() async {
    emit(state.copyWith(avatarStatus: BlocStatus.loading, avatarFailure: null));

    final Either<Failure, Unit> result = await _removeAvatar(const NoParams());
    if (isClosed) return;
    emit(
      result.fold(
        (Failure l) => state.copyWith(
          avatarStatus: BlocStatus.error,
          avatarFailure: l,
        ),
        (_) => state.copyWith(
          avatarStatus: BlocStatus.success,
          profile: (state.profile ?? const ProfileEntity()).copyWith(avatarUrl: null),
        ),
      ),
    );
  }
}
