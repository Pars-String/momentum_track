import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/services/database_service.dart';

class OverviewLocalProvider {
  final DatabaseService dbService;
  OverviewLocalProvider(this.dbService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    return await dbService.getTimeEntriesForOneMonth(
      date: date ?? DateTime.now(),
    );
  }
}
