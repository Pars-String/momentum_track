part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class InitDateList extends DetailsEvent {
  final DateTime? date;
  const InitDateList({this.date});

  @override
  List<Object> get props => [date ?? CalculatingHelper.today()];
}

class InitTimeEntriesList extends DetailsEvent {
  final int projectID;
  const InitTimeEntriesList({required this.projectID});

  @override
  List<Object> get props => [projectID];
}

class SelectNewDate extends DetailsEvent {
  final DateTime date;
  final int projectID;
  const SelectNewDate({required this.date, required this.projectID});

  @override
  List<Object> get props => [date, projectID];
}

class AddNewTimeEntry extends DetailsEvent {
  final int projectID;
  final String? note;
  final DateTime startTime;
  final DateTime? endTime;

  const AddNewTimeEntry({
    required this.projectID,
    this.note,
    required this.startTime,
    this.endTime,
  });

  @override
  List<Object> get props => [
    projectID,
    note ?? '',
    startTime,
    endTime ?? DateTime.now(),
  ];
}

class EditTimeEntry extends DetailsEvent {
  final int id;
  final String? note;
  final DateTime startTime;
  final DateTime? endTime;

  const EditTimeEntry({
    required this.id,
    this.note,
    required this.startTime,
    this.endTime,
  });

  @override
  List<Object> get props => [
    id,
    note ?? '',
    startTime,
    endTime ?? DateTime.now(),
  ];
}
