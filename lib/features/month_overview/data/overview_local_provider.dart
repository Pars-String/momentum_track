import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';

class OverviewLocalProvider {
  final DatabaseService dbService;
  OverviewLocalProvider(this.dbService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    final DateTime sDate =
        date?.copyWith(hour: 0, minute: 0, second: 0) ??
        CalculatingHelper.today();
    final DateTime eDate = CalculatingHelper.calculateLastDayOfMonth(
      sDate,
    ).gregorianLastDay;

    return await dbService.getTimeEntriesForSpecificDate(
      eDate: eDate,
      sDate: sDate.copyWith(day: 1),
    );
  }
}
