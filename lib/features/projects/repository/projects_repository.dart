import 'package:momentum_track/core/data/services/global_date_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/features/projects/data/projects_local_provider.dart';
import 'package:momentum_track/features/projects/data/projects_service.dart';

class ProjectsRepository {
  final ProjectsLocalProvider dbProvider;
  final ProjectsService service;
  final GlobalDateService dateService;
  ProjectsRepository(this.dbProvider, this.service, this.dateService);

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
    final DateTime sDate =
        date?.copyWith(hour: 0, minute: 0, second: 0) ?? DateHelper.today();
    final DateTime eDate = dateService
        .calculateLastDayOfMonth(sDate)
        .gregorianLastDay;
    return await dbProvider.getThisMonthTimeEntry(sDate, eDate);
  }

  Future<Duration> calculateDurationFrom(
    List<TimeEntry> timeEntries,
    int projectID,
  ) async {
    return await service.calculateDurationFrom(timeEntries, projectID);
  }
}
