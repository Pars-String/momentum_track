import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/features/streak_tracker/repository/streak_repository.dart';

part 'status/calendar_status.dart';
part 'status/duration_status.dart';
part 'streak_state.dart';

class StreakCubit extends Cubit<StreakState> {
  final StreakRepository _streakRepository;
  StreakCubit(this._streakRepository)
    : super(
        StreakState(
          calendarStatus: CalendarInitial(),
          durationStatus: DurationInitial(),
        ),
      );

  void loadStreakCalendar() {
    emit(state.copyWith(calendarStatus: CalendarLoading()));

    final monthDates = _streakRepository.buildActivityWeeks();
    emit(
      state.copyWith(calendarStatus: CalendarLoaded(monthDates: monthDates)),
    );
  }

  void loadStreakDurations() async {
    emit(state.copyWith(durationStatus: DurationLoading()));

    final durations = await _streakRepository.buildStreakHeatMap(
      DateTime.now(),
    );
    emit(
      state.copyWith(
        durationStatus: DurationLoaded(timelineDurations: durations),
      ),
    );
  }
}
