part of 'project_details_bloc.dart';

sealed class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitDateList extends ProjectDetailsEvent {
  final List<DateTime> dateList;
  const InitDateList(this.dateList);

  @override
  List<Object> get props => [dateList];
}

class InitTimeEntriesList extends ProjectDetailsEvent {
  final int projectID;
  final List<DateTime> dateList;
  const InitTimeEntriesList({required this.projectID, required this.dateList});

  @override
  List<Object> get props => [projectID, dateList];
}

class SelectNewDate extends ProjectDetailsEvent {
  final DateTime date;
  final int projectID;
  const SelectNewDate({required this.date, required this.projectID});

  @override
  List<Object> get props => [date, projectID];
}

class AddNewTimeEntry extends ProjectDetailsEvent {
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

class EditTimeEntry extends ProjectDetailsEvent {
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
