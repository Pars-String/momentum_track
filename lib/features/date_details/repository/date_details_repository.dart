import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/date_details/data/date_details_local_provider.dart';

class DateDetailsRepository {
  final DateDetailsLocalProvider dbProvider;

  DateDetailsRepository(this.dbProvider);

  Future<TimeEntry> addNewTimeEntry({
    required int projectId,
    String? note,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    return await dbProvider.addNewTimeEntry(
      projectId: projectId,
      note: note,
      startTime: startTime,
      endTime: endTime,
    );
  }

  Future<TimeEntry> updateTimeEntry({
    required TimeEntry timeEntry,
    required int projectId,
    String? note,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    return await dbProvider.updateTimeEntry(
      timeEntry: timeEntry,
      projectId: projectId,
      note: note,
      startTime: startTime,
      endTime: endTime,
    );
  }

  Future<List<Project>> getAllProjects() async {
    return await dbProvider.getAllProjects();
  }

  Future<List<TimeEntry>> getTimeEntriesForOneDay({
    required DateTime selectedDate,
  }) async {
    return await dbProvider.getTimeEntriesForOneDay(selectedDate: selectedDate);
  }
}
