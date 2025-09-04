part of 'projects_bloc.dart';

sealed class ProjectsEvent {}

class LoadProjects extends ProjectsEvent {
  final DateTime? date;

  LoadProjects({this.date});
}

class AddNewProject extends ProjectsEvent {
  final String projectName;
  final String? description;
  final DateTime? startDate;

  AddNewProject({
    required this.projectName,
    required this.description,
    required this.startDate,
  });
}

class EditProject extends ProjectsEvent {
  final Project projectInfo;

  EditProject({required this.projectInfo});
}

class DeleteProject extends ProjectsEvent {
  final int projectID;

  DeleteProject(this.projectID);
}
