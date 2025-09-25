import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/repositories/global_repository.dart';

part 'global_date_state.dart';

class GlobalDateCubit extends Cubit<GlobalDateState> {
  final GlobalRepository _repository;
  Timer? _timer;
  GlobalDateCubit(this._repository)
    : super(
        GlobalDateState(
          today: DateTime.now(),
          thisMonthDates: const [],
          dateListStatus: DateListStatus.initial,
        ),
      ) {
    Future.delayed(Duration(seconds: 60 - state.today.second), () {
      _checkAndUpdateDate();
      _startChecking();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _startChecking() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkAndUpdateDate();
    });
  }

  void _checkAndUpdateDate() {
    final now = DateTime.now();
    if (_isNewDay(now)) {
      emit(state.copyWith(today: now));
    }
  }

  bool _isNewDay(DateTime now) {
    return now.day != state.today.day ||
        now.month != state.today.month ||
        now.year != state.today.year;
  }

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
