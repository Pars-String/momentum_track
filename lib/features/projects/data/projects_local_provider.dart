import 'package:drift/drift.dart';
import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';

class ProjectsLocalProvider {
  final DatabaseService dbService;
  ProjectsLocalProvider(this.dbService);

  Future<void> addProject({
    required String projectName,
    required String? description,
    required DateTime? startDate,
  }) async {
    await dbService.insertProject(
      ProjectsCompanion(
        name: Value(projectName),
        description: Value(description),
        startDate: Value(startDate),
        createAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateProject({required Project project}) async {
    await dbService.updateProject(
      ProjectsCompanion(
        id: Value(project.id),
        name: Value(project.name),
        createAt: Value(project.createAt),
        description: Value(project.description),
        startDate: Value(project.startDate),
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

  Future<List<TimeEntry>> getThisMonthTimeEntry(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await dbService.getTimeEntriesForSpecificDate(
      eDate: endDate,
      sDate: startDate.copyWith(day: 1),
    );
  }
}
