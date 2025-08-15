import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';

class OverviewLocalProvider {
  final DatabaseService dbService;
  OverviewLocalProvider(this.dbService);

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
