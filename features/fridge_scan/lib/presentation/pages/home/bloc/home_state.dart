part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    UserProfile? userProfile,
    @Default(<ScanResultEntity>[]) List<ScanResultEntity> recentScans,
    @Default(BlocStatus.initial) BlocStatus recentScansStatus,
  }) = _HomeState;
}
