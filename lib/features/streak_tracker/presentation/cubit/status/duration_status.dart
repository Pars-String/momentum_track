part of '../streak_cubit.dart';

sealed class DurationStatus extends Equatable {}

class DurationInitial extends DurationStatus {
  @override
  List<Object?> get props => [];
}

class DurationLoading extends DurationStatus {
  @override
  List<Object?> get props => [];
}

class DurationFetched extends DurationStatus {
  final Map<DateTime, double> timelineDurations;
  DurationFetched(this.timelineDurations);

  @override
  List<Object?> get props => [timelineDurations];
}

class DurationError extends DurationStatus {
  final String message;
  DurationError(this.message);

  @override
  List<Object?> get props => [message];
}
