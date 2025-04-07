import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/project_details/data/details_local_provider.dart';

class DetailsRepository {
  final DetailsLocalProvider localProvider;
  DetailsRepository(this.localProvider);

  Future<void> updateProject({
    required int projectId,
    required String newProjectName,
    required DateTime newStartDate,
    required String? newDescription,
  }) async {
    await localProvider.updateProject(
      projectId: projectId,
      newProjectName: newProjectName,
      newStartDate: newStartDate,
      newDescription: newDescription,
    );
  }

  Future<Project> getProject(int projectId) async {
    return await localProvider.getProject(projectId);
  }

  Future<List<TimeEntry>> getTimeEntries({
    required int projectId,
    required DateTime selectedDate,
  }) async {
    return await localProvider.getTimeEntriesForOneDay(
      projectId: projectId,
      selectedDate: selectedDate,
    );
  }

  Future<List<DateTime>> getDateList(DateTime? selectedDate) async {
    final DateTime now = selectedDate ?? DateTime.now();
    final List<DateTime> dateList = [];
    final DateTime startOfWeek = now.subtract(
      Duration(days: (now.weekday - 1)),
    );

    int i = 0;
    while (i < 7) {
      final DateTime date = startOfWeek.add(Duration(days: i));
      dateList.add(
        date.copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ),
      );
      i++;
    }

    return dateList;
  }

  Future<TimeEntry> addNewTimeEntry({
    required int projectId,
    required String? note,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    return await localProvider.addNewTimeEntry(
      projectId: projectId,
      note: note,
      startTime: startTime,
      endTime: endTime,
    );
  }

  Future<TimeEntry> updateTimeEntry({
    required TimeEntry timeEntry,
    required String? note,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    return await localProvider.updateTimeEntry(
      timeEntry: timeEntry,
      note: note,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
