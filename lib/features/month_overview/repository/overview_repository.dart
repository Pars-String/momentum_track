import 'package:momentum_track/core/data/services/global_date_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/features/month_overview/data/overview_local_provider.dart';

class OverviewRepository {
  final OverviewLocalProvider dbProvider;
  final GlobalDateService dateService;

  OverviewRepository(this.dbProvider, this.dateService);

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    final DateTime sDate =
        date?.copyWith(hour: 0, minute: 0, second: 0) ?? DateHelper.today();
    final DateTime eDate = dateService
        .calculateLastDayOfMonth(sDate)
        .gregorianLastDay;
    return await dbProvider.getThisMonthTimeEntry(sDate, eDate);
  }
}
