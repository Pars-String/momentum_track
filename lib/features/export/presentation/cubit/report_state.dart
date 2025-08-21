// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'report_cubit.dart';

class ReportState extends Equatable {
  final ReportingStatus reportingStatus;
  final ExportingStatus exportingStatus;
  final List<Project> projects;
  const ReportState({
    required this.reportingStatus,
    required this.exportingStatus,
    required this.projects,
  });

  @override
  List<Object> get props => [reportingStatus, exportingStatus, projects];

  ReportState copyWith({
    ReportingStatus? reportingStatus,
    ExportingStatus? exportingStatus,
    List<Project>? projects,
  }) {
    return ReportState(
      reportingStatus: reportingStatus ?? this.reportingStatus,
      exportingStatus: exportingStatus ?? this.exportingStatus,
      projects: projects ?? this.projects,
    );
  }
}
