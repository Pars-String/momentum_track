import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/projects/repository/projects_repository.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsRepository repository;
  ProjectsBloc(this.repository) : super(ProjectsState()) {
    on<LoadProjects>((event, emit) async {
      emit(state.copyWith(status: ProjectsStatus.loading));
      try {
        final timeEntries = await repository.getThisMonthTimeEntry(event.date);
        final projects = await repository.getProjects();
        emit(
          state.copyWith(
            status: ProjectsStatus.success,
            projects: projects,
            timeEntries: timeEntries,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: ProjectsStatus.failure));
      }
    });

    on<AddNewProject>((event, emit) async {
      emit(state.copyWith(status: ProjectsStatus.loading));
      try {
        await repository.addProject(event.projectName);
        final projects = await repository.getProjects();
        emit(
          state.copyWith(status: ProjectsStatus.success, projects: projects),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: ProjectsStatus.success,
            projects: state.projects,
          ),
        );
      }
    });
  }
}
