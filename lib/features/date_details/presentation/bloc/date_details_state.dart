part of 'date_details_bloc.dart';

enum DateDetailsStatus { initial, loading, success, failure }

class DateDetailsState extends Equatable {
  final DateDetailsStatus dateDetailsStatus;
  final List<TimeEntry> timeEntries;
  final List<Project> projects;
  const DateDetailsState({
    this.dateDetailsStatus = DateDetailsStatus.initial,
    this.timeEntries = const [],
    this.projects = const [],
  });

  @override
  List<Object> get props => [dateDetailsStatus, timeEntries, projects];

  DateDetailsState copyWith({
    DateDetailsStatus? dateDetailsStatus,
    List<TimeEntry>? timeEntries,
    List<Project>? projects,
  }) {
    return DateDetailsState(
      dateDetailsStatus: dateDetailsStatus ?? this.dateDetailsStatus,
      timeEntries: timeEntries ?? this.timeEntries,
      projects: projects ?? this.projects,
    );
  }
}
