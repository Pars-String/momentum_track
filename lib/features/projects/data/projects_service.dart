import 'package:flutter/foundation.dart';
import 'package:momentum_track/core/database/app_database.dart';

class ProjectsService {
  Future<Map<int, Duration>> calculateDurationFrom(
    List<TimeEntry> timeEntries,
  ) async {
    final Map<int, Duration> durationsList = {};
    final List<int> projectIDs = await compute(_extractProjectIDs, timeEntries);

    for (var projectID in projectIDs) {
      final args = (timeEntries, projectID);
      Duration totalDuration = await compute(_calculateDurationFrom, args);
      durationsList[projectID] = totalDuration;
    }

    return durationsList;
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

List<int> _extractProjectIDs(List<TimeEntry> timeEntries) {
  final projectIDs = timeEntries
      .map((entry) => entry.projectId)
      .toSet()
      .toList();

  return projectIDs;
}
