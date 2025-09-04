import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/projects/repository/projects_repository.dart';

part 'project_overview_state.dart';

class ProjectOverviewCubit extends Cubit<ProjectOverviewState> {
  final ProjectsRepository _repository;
  ProjectOverviewCubit(this._repository) : super(ProjectOverviewInitial());

  Future<void> loadProjectDuration(List<TimeEntry> timeEntries) async {
    emit(ProjectOverviewLoading());

    try {
      final durations = await _repository.calculateDurationFrom(timeEntries);
      emit(ProjectOverviewLoaded(durations));
    } catch (e) {
      emit(ProjectOverviewFailure());
    }
  }

  void reset() {
    emit(ProjectOverviewInitial());
  }
}
