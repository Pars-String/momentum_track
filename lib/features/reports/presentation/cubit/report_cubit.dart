import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/reports/repository/reports_repository.dart';

part 'report_state.dart';
part 'status/exporting_status.dart';
part 'status/reporting_status.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportsRepository repository;
  ReportCubit(this.repository)
    : super(
        ReportState(
          reportingStatus: ReportingInitial(),
          exportingStatus: ExportingInitial(),
          projects: [],
        ),
      );

  void getAllProjects() async {
    await repository.getAllProjects().then((value) {
      emit(state.copyWith(projects: value));
    });
  }

  void getAllTimeEntries({
    required int projectId,
    required DateTime date,
  }) async {
    emit(state.copyWith(reportingStatus: ReportingLoading()));

    await repository.getThisMonthTimeEntry(projectId, date).then((value) {
      emit(
        state.copyWith(reportingStatus: ReportingSuccess(timeEntries: value)),
      );
    });
  }

  void changeExportingStatus(ExportingStatus status) {
    emit(state.copyWith(exportingStatus: status));
  }

  void reset() {
    emit(
      state.copyWith(
        reportingStatus: ReportingInitial(),
        exportingStatus: ExportingInitial(),
      ),
    );
  }
}
