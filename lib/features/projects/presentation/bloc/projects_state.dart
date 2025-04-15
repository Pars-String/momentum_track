// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_bloc.dart';

enum ProjectsStatus { initial, loading, success, failure }

class ProjectsState extends Equatable {
  final ProjectsStatus status;
  final List<Project> projects;
  final List<TimeEntry> timeEntries;

  const ProjectsState({
    this.status = ProjectsStatus.initial,
    this.projects = const [],
    this.timeEntries = const [],
  });

  ProjectsState copyWith({
    ProjectsStatus? status,
    List<Project>? projects,
    List<TimeEntry>? timeEntries,
  }) {
    return ProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      timeEntries: timeEntries ?? this.timeEntries,
    );
  }

  @override
  List<Object?> get props => [status, projects, timeEntries];
}
