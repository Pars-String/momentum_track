part of 'streak_cubit.dart';

sealed class StreakState extends Equatable {
  const StreakState();

  @override
  List<Object> get props => [];
}

final class StreakInitial extends StreakState {}

final class StreakLoading extends StreakState {}

class StreakLoaded extends StreakState {
  final Map<int, List<DateTime>> monthDates;
  const StreakLoaded({required this.monthDates});

  @override
  List<Object> get props => [monthDates];
}

final class StreakError extends StreakState {
  final String message;
  const StreakError({required this.message});

  @override
  List<Object> get props => [message];
}
