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
          generalStatus: StreakStatus.initial,
        ),
      );

  void loadStreakCalendar() {
    emit(
      state.copyWith(
        calendarStatus: CalendarLoading(),
        generalStatus: StreakStatus.calculating,
      ),
    );

    final monthDates = _streakRepository.buildActivityWeeks();
    emit(
      state.copyWith(
        calendarStatus: CalendarGenerated(monthDates),
        generalStatus: StreakStatus.completedFirstStep,
      ),
    );
  }

  void loadStreakDurations() async {
    emit(
      state.copyWith(
        durationStatus: DurationLoading(),
        generalStatus: StreakStatus.calculating,
      ),
    );

    final durations = await _streakRepository.buildStreakHeatMap(
      DateTime.now(),
    );
    emit(
      state.copyWith(
        durationStatus: DurationFetched(durations),
        generalStatus: StreakStatus.completedSecondStep,
      ),
    );
  }

  void resetStreakHeatMap() {
    emit(
      state.copyWith(
        generalStatus: StreakStatus.initial,
        calendarStatus: CalendarInitial(),
        durationStatus: DurationInitial(),
      ),
    );
  }
}
