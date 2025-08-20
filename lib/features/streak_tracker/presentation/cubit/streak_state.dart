// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'streak_cubit.dart';

enum StreakStatus {
  initial,
  calculating,
  completedFirstStep,
  completedSecondStep,
  error,
}

class StreakState extends Equatable {
  final StreakStatus generalStatus;
  final CalendarStatus calendarStatus;
  final DurationStatus durationStatus;
  const StreakState({
    required this.generalStatus,
    required this.calendarStatus,
    required this.durationStatus,
  });

  @override
  List<Object> get props => [calendarStatus, durationStatus, generalStatus];

  StreakState copyWith({
    StreakStatus? generalStatus,
    CalendarStatus? calendarStatus,
    DurationStatus? durationStatus,
  }) {
    return StreakState(
      generalStatus: generalStatus ?? this.generalStatus,
      calendarStatus: calendarStatus ?? this.calendarStatus,
      durationStatus: durationStatus ?? this.durationStatus,
    );
  }
}
