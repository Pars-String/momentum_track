// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'overview_bloc.dart';

enum OverviewStatus { initial, loading, success, failure }

class OverviewState extends Equatable {
  final OverviewStatus overviewStatus;
  final List<TimeEntry> timeEntries;
  final List<DateTime> dates;
  const OverviewState({
    this.overviewStatus = OverviewStatus.initial,
    this.timeEntries = const [],
    this.dates = const [],
  });

  @override
  List<Object> get props => [overviewStatus, timeEntries, dates];

  OverviewState copyWith({
    OverviewStatus? overviewStatus,
    List<TimeEntry>? timeEntries,
    List<DateTime>? dates,
  }) {
    return OverviewState(
      overviewStatus: overviewStatus ?? this.overviewStatus,
      timeEntries: timeEntries ?? this.timeEntries,
      dates: dates ?? this.dates,
    );
  }
}
