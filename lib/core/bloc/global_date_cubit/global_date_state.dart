part of 'global_date_cubit.dart';

enum DateListStatus { initial, loading, success, failure }

class GlobalDateState extends Equatable {
  final List<DateTime> thisMonthDates;
  final DateListStatus dateListStatus;
  const GlobalDateState({
    this.thisMonthDates = const [],
    this.dateListStatus = DateListStatus.initial,
  });

  @override
  List<Object> get props => [thisMonthDates, dateListStatus];

  GlobalDateState copyWith({
    List<DateTime>? thisMonthDates,
    DateListStatus? dateListStatus,
  }) {
    return GlobalDateState(
      thisMonthDates: thisMonthDates ?? this.thisMonthDates,
      dateListStatus: dateListStatus ?? this.dateListStatus,
    );
  }
}
