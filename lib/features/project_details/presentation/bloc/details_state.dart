// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

class DetailsState extends Equatable {
  final DetailsDateStatus detailsDateStatus;
  final ProjectTimeEntryStatus projectTimeEntryStatus;
  final DateTime selectedDate;
  const DetailsState({
    required this.detailsDateStatus,
    required this.projectTimeEntryStatus,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [
    detailsDateStatus,
    projectTimeEntryStatus,
    selectedDate,
  ];

  DetailsState copyWith({
    DetailsDateStatus? detailsDateStatus,
    ProjectTimeEntryStatus? projectTimeEntryStatus,
    DateTime? selectedDate,
  }) {
    return DetailsState(
      detailsDateStatus: detailsDateStatus ?? this.detailsDateStatus,
      projectTimeEntryStatus:
          projectTimeEntryStatus ?? this.projectTimeEntryStatus,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
