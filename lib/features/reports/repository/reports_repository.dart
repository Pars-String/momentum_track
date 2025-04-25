import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/reports/data/reports_local_provider.dart';

class ReportsRepository {
  final ReportsLocalProvider dbProvider;
  ReportsRepository(this.dbProvider);

  Future<List<TimeEntry>> getThisMonthTimeEntry(
    int projectId,
    DateTime date,
  ) async {
    return await dbProvider.getThisMonthTimeEntry(projectId, date);
  }

  Future<List<Project>> getAllProjects() async {
    return await dbProvider.getAllProjects();
  }
}
