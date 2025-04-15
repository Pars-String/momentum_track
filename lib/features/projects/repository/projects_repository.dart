import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/projects/data/projects_local_provider.dart';

class ProjectsRepository {
  final ProjectsLocalProvider dbProvider;
  ProjectsRepository(this.dbProvider);

  Future<void> addProject(String projectName) async {
    await dbProvider.addProject(projectName);
  }

  Future<void> updateProject({
    required int projectId,
    required String newProjectName,
    required DateTime newStartDate,
    required String? newDescription,
  }) async {
    await dbProvider.updateProject(
      projectId: projectId,
      newProjectName: newProjectName,
      newStartDate: newStartDate,
      newDescription: newDescription,
    );
  }

  Future<void> deleteProject(int projectId) async {
    await dbProvider.deleteProject(projectId);
  }

  Future<List<Project>> getProjects() async {
    return await dbProvider.getProjects();
  }

  Future<Project> getProject(int projectId) async {
    return await dbProvider.getProject(projectId);
  }

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    return await dbProvider.getThisMonthTimeEntry(date);
  }
}
