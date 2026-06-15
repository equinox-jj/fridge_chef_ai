import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/network/failure.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/fpdart/fpdart.dart';
import 'package:dependencies/freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/scan_result_entity.dart';
import '../../../../domain/usecases/get_scan_history_usecase.dart';

part 'scan_history_cubit.freezed.dart';
part 'scan_history_state.dart';

/// Drives the scan-history screen: loads the user's full scan history once and
/// exposes it for the list / empty / error states.
class ScanHistoryCubit extends Cubit<ScanHistoryState> {
  ScanHistoryCubit(this._getScanHistory) : super(const ScanHistoryState());

  final GetScanHistoryUseCase _getScanHistory;

  Future<void> load() async {
    emit(state.copyWith(status: BlocStatus.loading));

    final Either<Failure, List<ScanResultEntity>> result =
        await _getScanHistory(const NoParams());

    if (isClosed) return;

    emit(
      result.fold(
        (Failure _) => state.copyWith(status: BlocStatus.error),
        (List<ScanResultEntity> scans) => state.copyWith(
          scans: scans,
          status: scans.isEmpty ? BlocStatus.empty : BlocStatus.success,
        ),
      ),
    );
  }
}
