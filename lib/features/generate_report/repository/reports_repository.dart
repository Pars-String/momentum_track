import 'package:momentum_track/core/data/services/global_date_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/date_reset_extension.dart';
import 'package:momentum_track/features/generate_report/data/reports_local_provider.dart';

class ReportsRepository {
  final ReportsLocalProvider dbProvider;
  final GlobalDateService dateService;
  ReportsRepository(this.dbProvider, this.dateService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(int projectId) async {
    final DateTime now = DateTime.now().resetTime;
    final DateTime eDate = dateService
        .calculateLastDayOfMonth(now)
        .gregorianLastDay;

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
