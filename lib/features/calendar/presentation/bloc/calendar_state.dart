// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  final CalendarStatus overviewStatus;
  final List<TimeEntry> timeEntries;
  const CalendarState({
    this.overviewStatus = CalendarStatus.initial,
    this.timeEntries = const [],
  });

  @override
  List<Object> get props => [overviewStatus, timeEntries];

  CalendarState copyWith({
    CalendarStatus? overviewStatus,
    List<TimeEntry>? timeEntries,
  }) {
    return CalendarState(
      overviewStatus: overviewStatus ?? this.overviewStatus,
      timeEntries: timeEntries ?? this.timeEntries,
    );
  }
}
