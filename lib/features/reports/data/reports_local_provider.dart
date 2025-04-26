import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/services/database_service.dart';

class ReportsLocalProvider {
  final DatabaseService dbService;
  ReportsLocalProvider(this.dbService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(
    int projectId,
    DateTime date,
  ) async {
    return await dbService.getTimeEntriesForOneMonth(
      date: date,
      projectId: projectId,
    );
  }

  Future<List<Project>> getAllProjects() async {
    return await dbService.getAllProjects();
  }
}
