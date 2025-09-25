part of '../report_cubit.dart';

sealed class ExportingStatus extends Equatable {}

class ExportingInitial extends ExportingStatus {
  @override
  List<Object?> get props => [];
}

class ExportingLoading extends ExportingStatus {
  @override
  List<Object?> get props => [];
}

class ExportingSuccess extends ExportingStatus {
  @override
  List<Object?> get props => [];
}

class ExportingFailure extends ExportingStatus {
  @override
  List<Object?> get props => [];
}
