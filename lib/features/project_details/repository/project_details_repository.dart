import 'package:momentum_track/core/data/models/time_entry_form.dart';
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

  Future<List<Project>> getAllProjects() async {
    return await localProvider.getAllProjects();
  }

  Future<void> deleteTimeEntry(int timeEntryId) async {
    await localProvider.deleteTimeEntry(timeEntryId);
  }

  Future<List<TimeEntry>> getTimeEntries({
    required int projectId,
    required DateTime sDate,
    required DateTime eDate,
  }) async {
    return await localProvider.getTimeEntriesForOneMonth(
      projectId: projectId,
      sDate: sDate,
      eDate: eDate,
    );
  }

  Future<TimeEntry> addNewTimeEntry({required TimeEntryForm timeEntry}) async {
    return await localProvider.addNewTimeEntry(timeEntry: timeEntry);
  }

  Future<TimeEntry> updateTimeEntry({required TimeEntryForm timeEntry}) async {
    return await localProvider.updateTimeEntry(timeEntry: timeEntry);
  }
}
