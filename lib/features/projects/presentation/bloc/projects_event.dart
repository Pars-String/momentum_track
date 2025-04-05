part of 'projects_bloc.dart';

sealed class ProjectsEvent {}

class LoadProjects extends ProjectsEvent {}

class AddNewProject extends ProjectsEvent {
  final String projectName;

  AddNewProject(this.projectName);
}
