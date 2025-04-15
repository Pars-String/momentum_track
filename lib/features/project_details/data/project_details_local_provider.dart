import 'package:drift/drift.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/services/database_service.dart';
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

  Future<TimeEntry> addNewTimeEntry({
    required int projectId,
    String? note,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    double? duration;
    if (endTime != null) {
      duration = CalculatingHelper.calculateDuration(
        startAt: startTime,
        endAt: endTime,
      );
    }

    final int id = await dbService.insertTimeEntry(
      TimeEntriesCompanion(
        projectId: Value(projectId),
        note: Value(note),
        startTime: Value(startTime),
        endTime: Value(endTime),
        duration: Value(duration),
        createAt: Value(DateTime.now()),
      ),
    );

    return TimeEntry(
      id: id,
      projectId: projectId,
      note: note,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      createAt: DateTime.now(),
    );
  }

  Future<TimeEntry> updateTimeEntry({
    required TimeEntry timeEntry,
    String? note,
    required DateTime startTime,
    DateTime? endTime,
  }) async {
    double? duration;
    if (endTime != null) {
      duration = CalculatingHelper.calculateDuration(
        startAt: startTime,
        endAt: endTime,
      );
    }

    await dbService.updateTimeEntry(
      timeEntry.copyWith(
        note: Value(note),
        startTime: startTime,
        endTime: Value(endTime),
        duration: Value(duration),
      ),
    );

    return TimeEntry(
      id: timeEntry.id,
      projectId: timeEntry.projectId,
      note: note,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      createAt: timeEntry.createAt,
    );
  }

  Future<Project> getProject(int projectId) async {
    return await dbService.getProject(projectId);
  }

  Future<List<TimeEntry>> getTimeEntriesForOneMonth({
    required int projectId,
    required DateTime selectedDate,
  }) async {
    return await dbService.getTimeEntriesForOneMonthByProjectID(
      projectId: projectId,
      date: selectedDate,
    );
  }
}
