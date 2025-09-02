part of '../project_details_bloc.dart';

sealed class ProjectDetailsStatus {}

class ProjectDetailsInitial extends ProjectDetailsStatus {}

class ProjectDetailsLoading extends ProjectDetailsStatus {}

class ProjectDetailsSuccess extends ProjectDetailsStatus {
  final Project projectInfo;
  ProjectDetailsSuccess({required this.projectInfo});
}

class ProjectDetailsFailure extends ProjectDetailsStatus {
  final String error;
  ProjectDetailsFailure({required this.error});
}
