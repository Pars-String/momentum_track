import 'package:momentum_track/core/data/services/global_date_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/date_reset_extension.dart';
import 'package:momentum_track/features/calendar/data/calendar_local_provider.dart';

class CalendarRepository {
  final CalendarLocalProvider _dbProvider;
  final GlobalDateService _dateService;

  CalendarRepository(this._dbProvider, this._dateService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    final DateTime sDate = date?.resetTime ?? DateTime.now().resetTime;

    final DateTime eDate = _dateService
        .calculateLastDayOfMonth(sDate)
        .gregorianLastDay;
    return await _dbProvider.getThisMonthTimeEntry(sDate, eDate);
  }
}
