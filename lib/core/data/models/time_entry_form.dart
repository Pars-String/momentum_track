class TimeEntryForm {
  final int? id;
  final int? projectID;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? createAt;
  final double? duration;
  TimeEntryForm({
    this.id,
    required this.projectID,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.createAt,
    this.duration,
  });

  TimeEntryForm copyWith({
    int? id,
    int? projectID,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createAt,
    double? duration,
  }) {
    return TimeEntryForm(
      id: id ?? this.id,
      projectID: projectID ?? this.projectID,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createAt: createAt ?? this.createAt,
      duration: duration ?? this.duration,
    );
  }
}
