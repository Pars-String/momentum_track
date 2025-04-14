part of 'overview_bloc.dart';

sealed class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object> get props => [];
}

class InitThisMonth extends OverviewEvent {
  final DateTime? date;
  const InitThisMonth({this.date});
}
