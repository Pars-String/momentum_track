part of 'project_details_bloc.dart';

sealed class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitProjectDetails extends ProjectDetailsEvent {
  final List<DateTime> thisMonthDates;
  final int projectID;
  const InitProjectDetails(this.thisMonthDates, this.projectID);

  @override
  List<Object> get props => [thisMonthDates, projectID];
}

// class SelectNewDate extends ProjectDetailsEvent {
//   final DateTime date;
//   final int projectID;
//   const SelectNewDate({required this.date, required this.projectID});

//   @override
//   List<Object> get props => [date, projectID];
// }

class AddNewTimeEntry extends ProjectDetailsEvent {
  final TimeEntryForm timeEntry;

  const AddNewTimeEntry({required this.timeEntry});

  @override
  List<Object> get props => [timeEntry];
}

class EditTimeEntry extends ProjectDetailsEvent {
  final TimeEntryForm timeEntry;

  const EditTimeEntry({required this.timeEntry});

  @override
  List<Object> get props => [timeEntry];
}

class DeleteTimeEntry extends ProjectDetailsEvent {
  final int timeEntryID;

  const DeleteTimeEntry({required this.timeEntryID});

  @override
  List<Object> get props => [timeEntryID];
}
