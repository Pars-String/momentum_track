part of '../report_cubit.dart';

sealed class ReportingStatus extends Equatable {}

class ReportingInitial extends ReportingStatus {
  @override
  List<Object?> get props => [];
}

class ReportingLoading extends ReportingStatus {
  @override
  List<Object?> get props => [];
}

class ReportingSuccess extends ReportingStatus {
  final List<TimeEntry> timeEntries;
  ReportingSuccess({required this.timeEntries});
  @override
  List<Object?> get props => [timeEntries];
}

class ReportingFailure extends ReportingStatus {
  @override
  List<Object?> get props => [];
}
