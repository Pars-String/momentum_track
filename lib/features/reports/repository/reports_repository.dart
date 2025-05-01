import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/features/reports/data/reports_local_provider.dart';

class ReportsRepository {
  final ReportsLocalProvider dbProvider;
  ReportsRepository(this.dbProvider);

  Future<List<TimeEntry>> getThisMonthTimeEntry(int projectId) async {
    final DateTime now = CalculatingHelper.today();
    final DateTime eDate =
        CalculatingHelper.calculateLastDayOfMonth(now).gregorianLastDay;

    return await dbProvider.getTimeEntryInfo(
      projectId: projectId,
      sDate: now.copyWith(day: 1),
      eDate: eDate,
    );
  }

  Future<List<TimeEntry>> getCustomDateTimeEntry({
    required int projectId,
    required DateTime eDate,
    required DateTime sDate,
  }) async {
    return await dbProvider.getTimeEntryInfo(
      projectId: projectId,
      sDate: sDate,
      eDate: eDate,
    );
  }

  Future<List<Project>> getAllProjects() async {
    return await dbProvider.getAllProjects();
  }
}
