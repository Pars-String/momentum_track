part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class InitThisMonth extends CalendarEvent {
  final DateTime? date;
  const InitThisMonth({this.date});
}
