import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/features/streak_tracker/repository/streak_repository.dart';

part 'streak_state.dart';

class StreakCubit extends Cubit<StreakState> {
  final StreakRepository _streakRepository;
  StreakCubit(this._streakRepository) : super(StreakInitial());

  void loadStreakData() {
    emit(StreakLoading());

    final monthDates = _streakRepository.buildActivityWeeks();
    emit(StreakLoaded(monthDates: monthDates));
  }
}
