part of 'scan_bloc.dart';

@freezed
abstract class ScanState with _$ScanState {
  const factory ScanState({
    @Default(BlocStatus.initial) BlocStatus scanState,
    Failure? scanFailure,
    ScanEntity? scanResponse,
    List<IngredientEntity>? ingredientsResponse,
  }) = ScanInitial;
}
