part of 'projects_bloc.dart';

sealed class ProjectsEvent {}

class LoadProjects extends ProjectsEvent {
  final DateTime? date;

  LoadProjects({this.date});
}

class AddNewProject extends ProjectsEvent {
  final String projectName;

  AddNewProject(this.projectName);
}
