import 'package:drift/drift.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/services/database_service.dart';

class ProjectsLocalProvider {
  final DatabaseService dbService;
  ProjectsLocalProvider(this.dbService);

  Future<void> addProject(String projectName) async {
    await dbService.insertProject(
      ProjectsCompanion(
        name: Value(projectName),
        createAt: Value(DateTime.now()),
      ),
    );
  }

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

  Future<void> deleteProject(int projectId) async {
    await dbService.deleteProject(projectId);
  }

  Future<List<Project>> getProjects() async {
    return await dbService.getAllProjects();
  }

  Future<Project> getProject(int projectId) async {
    return await dbService.getProject(projectId);
  }

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    return await dbService.getTimeEntriesForOneMonth(
      date: date ?? DateTime.now(),
    );
  }
}
