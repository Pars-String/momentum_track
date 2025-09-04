import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';

class ReportsLocalProvider {
  final DatabaseService dbService;
  ReportsLocalProvider(this.dbService);

  Future<List<TimeEntry>> getTimeEntryInfo({
    required int projectId,
    required DateTime sDate,
    required DateTime eDate,
  }) async {
    return await dbService.getTimeEntriesForSpecificDate(
      eDate: eDate,
      sDate: sDate,
      projectId: projectId,
    );
  }

  Future<List<Project>> getAllProjects() async {
    return await dbService.getAllProjects();
  }
}
