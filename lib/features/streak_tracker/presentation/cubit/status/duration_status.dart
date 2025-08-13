part of '../streak_cubit.dart';

sealed class DurationStatus {}

class DurationInitial extends DurationStatus {}

class DurationLoading extends DurationStatus {}

class DurationLoaded extends DurationStatus {
  final Map<DateTime, double> timelineDurations;
  DurationLoaded({required this.timelineDurations});
}

class DurationError extends DurationStatus {
  final String message;
  DurationError({required this.message});
}
