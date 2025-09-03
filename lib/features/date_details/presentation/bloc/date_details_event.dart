part of 'date_details_bloc.dart';

sealed class DateDetailsEvent extends Equatable {
  const DateDetailsEvent();

  @override
  List<Object> get props => [];
}

class InitialDetails extends DateDetailsEvent {
  final DateTime selectedDate;

  const InitialDetails({required this.selectedDate});
}

class AddNewTimeEntry extends DateDetailsEvent {
  final TimeEntryForm timeEntryForm;

  const AddNewTimeEntry({required this.timeEntryForm});

  @override
  List<Object> get props => [timeEntryForm];
}

class EditTimeEntry extends DateDetailsEvent {
  final TimeEntryForm timeEntryForm;
  const EditTimeEntry({required this.timeEntryForm});

  @override
  List<Object> get props => [timeEntryForm];
}

class DeleteTimeEntry extends DateDetailsEvent {
  final int timeEntryID;

  const DeleteTimeEntry({required this.timeEntryID});

  @override
  List<Object> get props => [timeEntryID];
}
