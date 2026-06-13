import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/dietary/dietary_preference.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/profile_entity.dart';
import '../../../../domain/usecases/get_profile_usecase.dart';
import '../../../../domain/usecases/get_scan_count_usecase.dart';
import '../../../../domain/usecases/sign_out_usecase.dart';
import '../../../../domain/usecases/update_dietary_preference_usecase.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._getProfile,
    this._getScanCount,
    this._updateDietaryPreference,
    this._signOut,
  ) : super(const ProfileState());

  final GetProfileUseCase _getProfile;
  final GetScanCountUseCase _getScanCount;
  final UpdateDietaryPreferenceUseCase _updateDietaryPreference;
  final SignOutUseCase _signOut;

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
}
