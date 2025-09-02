part of 'project_details_bloc.dart';

enum AddOrEditTimeEntryStatus { initial, loading, success, failure }

class ProjectDetailsState extends Equatable {
  final ProjectDetailsStatus projectDetailsStatus;
  final List<DateTime> dates;
  final List<TimeEntry> timeEntries;
  final AddOrEditTimeEntryStatus addOrEditTimeEntryStatus;
  const ProjectDetailsState({
    required this.projectDetailsStatus,
    required this.dates,
    required this.timeEntries,
    required this.addOrEditTimeEntryStatus,
  });

  @override
  List<Object> get props => [
    projectDetailsStatus,
    dates,
    timeEntries,
    addOrEditTimeEntryStatus,
  ];

  ProjectDetailsState copyWith({
    ProjectDetailsStatus? projectDetailsStatus,
    List<DateTime>? dates,
    List<TimeEntry>? timeEntries,
    AddOrEditTimeEntryStatus? addOrEditTimeEntryStatus,
  }) {
    return ProjectDetailsState(
      projectDetailsStatus: projectDetailsStatus ?? this.projectDetailsStatus,
      dates: dates ?? this.dates,
      timeEntries: timeEntries ?? this.timeEntries,
      addOrEditTimeEntryStatus:
          addOrEditTimeEntryStatus ?? this.addOrEditTimeEntryStatus,
    );
  }
}
