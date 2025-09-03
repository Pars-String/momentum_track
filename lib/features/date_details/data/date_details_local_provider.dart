import 'package:drift/drift.dart';
import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';

class DateDetailsLocalProvider {
  final DatabaseService dbService;
  DateDetailsLocalProvider(this.dbService);

  Future<TimeEntry> addNewTimeEntry({
    required TimeEntryForm timeEntryForm,
  }) async {
    double? duration;
    if (timeEntryForm.endDate != null) {
      duration = CalculatingHelper.convertDurationToHours(
        startAt: timeEntryForm.startDate,
        endAt: timeEntryForm.endDate!,
      );
    }

    final int id = await dbService.insertTimeEntry(
      TimeEntriesCompanion(
        projectId: Value(timeEntryForm.projectID!),
        note: Value(timeEntryForm.description),
        startTime: Value(timeEntryForm.startDate),
        endTime: Value(timeEntryForm.endDate),
        duration: Value(duration),
        createAt: Value(DateTime.now()),
      ),
    );

    return TimeEntry(
      id: id,
      projectId: timeEntryForm.projectID!,
      note: timeEntryForm.description,
      startTime: timeEntryForm.startDate,
      endTime: timeEntryForm.endDate,
      duration: duration,
      createAt: DateTime.now(),
    );
  }

  Future<TimeEntry> updateTimeEntry({
    required TimeEntry timeEntry,
    required TimeEntryForm timeEntryForm,
  }) async {
    double? duration;
    if (timeEntryForm.endDate != null) {
      duration = CalculatingHelper.convertDurationToHours(
        startAt: timeEntryForm.startDate,
        endAt: timeEntryForm.endDate!,
      );
    }

    await dbService.updateTimeEntry(
      timeEntry.copyWith(
        note: Value(timeEntryForm.description),
        startTime: timeEntryForm.startDate,
        projectId: timeEntryForm.projectID,
        endTime: Value(timeEntryForm.endDate),
        duration: Value(duration),
      ),
    );

    return TimeEntry(
      id: timeEntryForm.id!,
      projectId: timeEntryForm.projectID!,
      note: timeEntryForm.description,
      startTime: timeEntryForm.startDate,
      endTime: timeEntryForm.endDate,
      duration: duration,
      createAt: timeEntry.createAt,
    );
  }

  Future<List<Project>> getAllProjects() async {
    return await dbService.getAllProjects();
  }

  Future<void> deleteTimeEntry(int timeEntryId) async {
    await dbService.deleteTimeEntry(timeEntryId);
  }

  Future<List<TimeEntry>> getTimeEntriesForOneDay({
    required DateTime selectedDate,
  }) async {
    return await dbService.getAllProjectsTimeEntriesForOneDay(
      date: selectedDate,
    );
  }
}
