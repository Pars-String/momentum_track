part of '../streak_cubit.dart';

sealed class CalendarStatus extends Equatable {}

class CalendarInitial extends CalendarStatus {
  @override
  List<Object?> get props => [];
}

class CalendarLoading extends CalendarStatus {
  @override
  List<Object?> get props => [];
}

class CalendarGenerated extends CalendarStatus {
  final Map<int, List<DateTime>> monthDates;
  CalendarGenerated(this.monthDates);

  @override
  List<Object?> get props => [monthDates];
}

class CalendarError extends CalendarStatus {
  final String message;
  CalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
