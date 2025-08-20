import 'package:flutter/foundation.dart';
import 'package:momentum_track/core/database/app_database.dart';

class ProjectsService {
  Future<Duration> calculateDurationFrom(
    List<TimeEntry> timeEntries,
    int projectID,
  ) async {
    final args = (timeEntries, projectID);
    Duration totalDuration = await compute(_calculateDurationFrom, args);

    return totalDuration;
  }
}

Duration _calculateDurationFrom((List<TimeEntry>, int) args) {
  final timeEntries = args.$1;
  final projectID = args.$2;
  final listedEntries = timeEntries
      .where((timeEntry) => timeEntry.projectId == projectID)
      .toList();

  Duration totalDuration = Duration.zero;
  for (var timeEntry in listedEntries) {
    totalDuration += timeEntry.duration != null
        ? Duration(seconds: (timeEntry.duration! * 3600).round())
        : Duration.zero;
  }

  return totalDuration;
}
