part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    UserProfile? userProfile,
    @Default(<ScanResultEntity>[]) List<ScanResultEntity> recentScans,
    @Default(BlocStatus.initial) BlocStatus recentScansStatus,

    /// True while a backend resync is in flight. Drives pull-to-refresh
    /// completion without coupling it to [recentScansStatus].
    @Default(false) bool isSyncing,
  }) = _HomeState;
}
