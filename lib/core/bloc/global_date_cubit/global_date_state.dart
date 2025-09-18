part of 'global_date_cubit.dart';

enum DateListStatus { initial, loading, success, failure }

class GlobalDateState extends Equatable {
  final DateTime today;
  final List<DateTime> thisMonthDates;
  final DateListStatus dateListStatus;
  const GlobalDateState({
    required this.today,
    required this.thisMonthDates,
    required this.dateListStatus,
  });

  @override
  List<Object> get props => [thisMonthDates, dateListStatus, today];

  GlobalDateState copyWith({
    DateTime? today,
    List<DateTime>? thisMonthDates,
    DateListStatus? dateListStatus,
  }) {
    return GlobalDateState(
      today: today ?? this.today,
      thisMonthDates: thisMonthDates ?? this.thisMonthDates,
      dateListStatus: dateListStatus ?? this.dateListStatus,
    );
  }
}
