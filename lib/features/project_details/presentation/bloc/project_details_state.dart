// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'project_details_bloc.dart';

class ProjectDetailsState extends Equatable {
  final DetailsDateStatus detailsDateStatus;
  final ProjectTimeEntryStatus projectTimeEntryStatus;
  final DateTime selectedDate;
  const ProjectDetailsState({
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

  ProjectDetailsState copyWith({
    DetailsDateStatus? detailsDateStatus,
    ProjectTimeEntryStatus? projectTimeEntryStatus,
    DateTime? selectedDate,
  }) {
    return ProjectDetailsState(
      detailsDateStatus: detailsDateStatus ?? this.detailsDateStatus,
      projectTimeEntryStatus:
          projectTimeEntryStatus ?? this.projectTimeEntryStatus,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
