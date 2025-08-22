part of '../project_details_bloc.dart';

sealed class ProjectTimeEntryStatus extends Equatable {}

class TimeEntryInitial extends ProjectTimeEntryStatus {
  @override
  List<Object?> get props => [];
}

class TimeEntryLoading extends ProjectTimeEntryStatus {
  @override
  List<Object?> get props => [];
}

class TimeEntrySuccess extends ProjectTimeEntryStatus {
  final List<TimeEntry> timeEntries;

  TimeEntrySuccess({required this.timeEntries});

  @override
  List<Object?> get props => [timeEntries];
}

class TimeEntryFailure extends ProjectTimeEntryStatus {
  final String error;

  TimeEntryFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
