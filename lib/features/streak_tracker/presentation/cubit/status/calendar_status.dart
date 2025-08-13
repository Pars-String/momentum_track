part of '../streak_cubit.dart';

sealed class CalendarStatus {}

class CalendarInitial extends CalendarStatus {}

class CalendarLoading extends CalendarStatus {}

class CalendarLoaded extends CalendarStatus {
  final Map<int, List<DateTime>> monthDates;
  CalendarLoaded({required this.monthDates});
}

class CalendarError extends CalendarStatus {
  final String message;
  CalendarError({required this.message});
}
