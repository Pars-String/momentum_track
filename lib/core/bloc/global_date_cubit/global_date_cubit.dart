import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/repositories/global_repository.dart';

part 'global_date_state.dart';

class GlobalDateCubit extends Cubit<GlobalDateState> {
  final GlobalRepository _repository;
  GlobalDateCubit(this._repository) : super(GlobalDateState());

  void setThisMonthDates() {
    emit(state.copyWith(dateListStatus: DateListStatus.loading));

    final List<DateTime> dateList = _repository
        .calculateFullMonthDates(null)
        .gregorianDates;

    emit(
      state.copyWith(
        dateListStatus: DateListStatus.success,
        thisMonthDates: dateList,
      ),
    );
  }

  void setNextMonthDates() {
    final DateTime nextMonth = state.thisMonthDates.last.add(Duration(days: 1));
    emit(state.copyWith(dateListStatus: DateListStatus.loading));

    final List<DateTime> dateList = _repository
        .calculateFullMonthDates(nextMonth)
        .gregorianDates;

    emit(
      state.copyWith(
        dateListStatus: DateListStatus.success,
        thisMonthDates: dateList,
      ),
    );
  }

  void setPreviousMonthDates() async {
    final DateTime previousMonth = state.thisMonthDates.first.subtract(
      Duration(days: 1),
    );
    emit(state.copyWith(dateListStatus: DateListStatus.loading));

    final List<DateTime> dateList = _repository
        .calculateFullMonthDates(previousMonth)
        .gregorianDates;

    emit(
      state.copyWith(
        dateListStatus: DateListStatus.success,
        thisMonthDates: dateList,
      ),
    );
  }
}
