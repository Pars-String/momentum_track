import 'package:drift/drift.dart';
import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';

class ProjectDetailsLocalProvider {
  final DatabaseService dbService;
  ProjectDetailsLocalProvider(this.dbService);

  Future<void> updateProject({
    required int projectId,
    required String newProjectName,
    required DateTime newStartDate,
    required String? newDescription,
  }) async {
    await dbService.updateProject(
      ProjectsCompanion(
        id: Value(projectId),
        name: Value(newProjectName),
        startDate: Value(newStartDate),
        description: Value(newDescription),
      ),
    );
  }

  Future<TimeEntry> addNewTimeEntry({required TimeEntryForm timeEntry}) async {
    double? duration;
    if (timeEntry.endDate != null) {
      duration = CalculatingHelper.convertDurationToHours(
        startAt: timeEntry.startDate,
        endAt: timeEntry.endDate!,
      );
    }

    final int id = await dbService.insertTimeEntry(
      TimeEntriesCompanion(
        projectId: Value(timeEntry.projectID!),
        note: Value(timeEntry.description),
        startTime: Value(timeEntry.startDate),
        endTime: Value(timeEntry.endDate),
        duration: Value(duration),
        createAt: Value(DateTime.now()),
      ),
    );

    return TimeEntry(
      id: id,
      projectId: timeEntry.projectID!,
      note: timeEntry.description,
      startTime: timeEntry.startDate,
      endTime: timeEntry.endDate,
      duration: duration,
      createAt: DateTime.now(),
    );
  }

  Future<TimeEntry> updateTimeEntry({required TimeEntryForm timeEntry}) async {
    double? duration;
    if (timeEntry.endDate != null) {
      duration = CalculatingHelper.convertDurationToHours(
        startAt: timeEntry.startDate,
        endAt: timeEntry.endDate!,
      );
    }

    await dbService.updateTimeEntryNew(timeEntry.copyWith(duration: duration));

    return TimeEntry(
      id: timeEntry.id!,
      projectId: timeEntry.projectID!,
      note: timeEntry.description,
      startTime: timeEntry.startDate,
      endTime: timeEntry.endDate,
      duration: duration,
      createAt: timeEntry.createAt!,
    );
  }

  Future<Project> getProject(int projectId) async {
    return await dbService.getProject(projectId);
  }

  Future<List<Project>> getAllProjects() async {
    return await dbService.getAllProjects();
  }

  Future<void> deleteTimeEntry(int timeEntryId) async {
    await dbService.deleteTimeEntry(timeEntryId);
  }

  Future<List<TimeEntry>> getTimeEntriesForOneMonth({
    required int projectId,
    required DateTime sDate,
    required DateTime eDate,
  }) async {
    return await dbService.getTimeEntriesForOneMonthByProjectID(
      projectId: projectId,
      sDate: sDate,
      eDate: eDate,
    );
  }
}
