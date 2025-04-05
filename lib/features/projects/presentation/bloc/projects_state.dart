part of 'projects_bloc.dart';

enum ProjectsStatus { initial, loading, success, failure }

class ProjectsState extends Equatable {
  final ProjectsStatus status;
  final List<Project> projects;

  const ProjectsState({
    this.status = ProjectsStatus.initial,
    this.projects = const [],
  });

  ProjectsState copyWith({ProjectsStatus? status, List<Project>? projects}) {
    return ProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [status, projects];
}
