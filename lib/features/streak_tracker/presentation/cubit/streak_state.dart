part of 'streak_cubit.dart';

class StreakState extends Equatable {
  final CalendarStatus calendarStatus;
  final DurationStatus durationStatus;
  const StreakState({
    required this.calendarStatus,
    required this.durationStatus,
  });

  @override
  List<Object> get props => [calendarStatus, durationStatus];

  StreakState copyWith({
    CalendarStatus? calendarStatus,
    DurationStatus? durationStatus,
  }) {
    return StreakState(
      calendarStatus: calendarStatus ?? this.calendarStatus,
      durationStatus: durationStatus ?? this.durationStatus,
    );
  }
}
