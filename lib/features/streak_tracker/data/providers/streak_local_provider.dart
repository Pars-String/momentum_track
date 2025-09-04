import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';

class StreakLocalProvider {
  final DatabaseService dbService;
  StreakLocalProvider(this.dbService);

  Future<List<TimeEntry>> updateStreakHeatMap(DateTime now) async {
    return await dbService.getTimeEntriesForSpecificDate(
      eDate: now,
      sDate: now.copyWith(year: now.year - 1),
    );
  }
}
