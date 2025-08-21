import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';

class CalendarLocalProvider {
  final DatabaseService _dbService;
  CalendarLocalProvider(this._dbService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _dbService.getTimeEntriesForSpecificDate(
      eDate: endDate,
      sDate: startDate.copyWith(day: 1),
    );
  }
}
