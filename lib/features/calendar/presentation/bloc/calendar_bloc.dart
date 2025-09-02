import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/calendar/repository/calendar_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository repository;
  CalendarBloc(this.repository) : super(CalendarState()) {
    on<InitThisMonth>((event, emit) async {
      emit(state.copyWith(overviewStatus: CalendarStatus.loading));

      await repository.getThisMonthTimeEntry(event.date).then((value) async {
        emit(
          state.copyWith(
            overviewStatus: CalendarStatus.success,
            timeEntries: value,
          ),
        );
      });
    });
  }
}
