import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';

part 'global_date_state.dart';

class GlobalDateCubit extends Cubit<GlobalDateState> {
  GlobalDateCubit() : super(GlobalDateState());

  void setThisMonthDates() {
    emit(state.copyWith(dateListStatus: DateListStatus.loading));

    final List<DateTime> dateList =
        CalculatingHelper.calculateMonthDates(null).gregorianDates;

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

    final List<DateTime> dateList =
        CalculatingHelper.calculateMonthDates(nextMonth).gregorianDates;

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

    final List<DateTime> dateList =
        CalculatingHelper.calculateMonthDates(previousMonth).gregorianDates;

    emit(
      state.copyWith(
        dateListStatus: DateListStatus.success,
        thisMonthDates: dateList,
      ),
    );
  }
}
