part of 'project_overview_cubit.dart';

sealed class ProjectOverviewState extends Equatable {
  const ProjectOverviewState();

  @override
  List<Object> get props => [];
}

final class ProjectOverviewInitial extends ProjectOverviewState {}

final class ProjectOverviewLoading extends ProjectOverviewState {}

final class ProjectOverviewLoaded extends ProjectOverviewState {
  final Map<int, Duration> durationsList;
  const ProjectOverviewLoaded(this.durationsList);

  @override
  List<Object> get props => [durationsList];
}

final class ProjectOverviewFailure extends ProjectOverviewState {}
