import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/projects/data/projects_local_provider.dart';

class ProjectsRepository {
  final ProjectsLocalProvider dbProvider;
  ProjectsRepository(this.dbProvider);

  Future<void> addProject({
    required String projectName,
    required String? description,
    required DateTime? startDate,
  }) async {
    await dbProvider.addProject(
      projectName: projectName,
      description: description,
      startDate: startDate,
    );
  }

  Future<void> updateProject({required Project project}) async {
    await dbProvider.updateProject(project: project);
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
