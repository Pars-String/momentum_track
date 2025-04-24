import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/month_overview/repository/overview_repository.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final OverviewRepository repository;
  OverviewBloc(this.repository) : super(OverviewState()) {
    on<InitThisMonth>((event, emit) async {
      emit(state.copyWith(overviewStatus: OverviewStatus.loading));

      await repository.getThisMonthTimeEntry(event.date).then((value) async {
        emit(
          state.copyWith(
            overviewStatus: OverviewStatus.success,
            timeEntries: value,
          ),
        );
      });
    });
  }
}
