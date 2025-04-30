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

class EditTimeEntry extends DateDetailsEvent {
  final int id;
  final int projectID;
  final String? note;
  final DateTime startTime;
  final DateTime? endTime;

  const EditTimeEntry({
    required this.id,
    required this.projectID,
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
