import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/project_details/data/project_details_local_provider.dart';

class ProjectDetailsRepository {
  final ProjectDetailsLocalProvider localProvider;
  ProjectDetailsRepository(this.localProvider);

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
    return await localProvider.getTimeEntriesForOneMonth(
      projectId: projectId,
      selectedDate: selectedDate,
    );
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
