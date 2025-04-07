part of '../details_bloc.dart';

sealed class DetailsDateStatus extends Equatable {}

class DetailsDateInitial extends DetailsDateStatus {
  @override
  List<Object?> get props => [];
}

class DetailsDateLoading extends DetailsDateStatus {
  @override
  List<Object?> get props => [];
}

class DetailsDateSuccess extends DetailsDateStatus {
  final List<DateTime> dateList;

  DetailsDateSuccess({required this.dateList});

  @override
  List<Object?> get props => [dateList];
}

class DetailsDateFailure extends DetailsDateStatus {
  final String error;

  DetailsDateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
