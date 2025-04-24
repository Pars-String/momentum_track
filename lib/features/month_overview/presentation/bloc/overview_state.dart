// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'overview_bloc.dart';

enum OverviewStatus { initial, loading, success, failure }

class OverviewState extends Equatable {
  final OverviewStatus overviewStatus;
  final List<TimeEntry> timeEntries;
  const OverviewState({
    this.overviewStatus = OverviewStatus.initial,
    this.timeEntries = const [],
  });

  @override
  List<Object> get props => [overviewStatus, timeEntries];

  OverviewState copyWith({
    OverviewStatus? overviewStatus,
    List<TimeEntry>? timeEntries,
  }) {
    return OverviewState(
      overviewStatus: overviewStatus ?? this.overviewStatus,
      timeEntries: timeEntries ?? this.timeEntries,
    );
  }
}
