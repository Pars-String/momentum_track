import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/month_overview/data/overview_local_provider.dart';

class OverviewRepository {
  final OverviewLocalProvider dbProvider;

  OverviewRepository(this.dbProvider);

  Future<List<TimeEntry>> getThisMonthTimeEntry(DateTime? date) async {
    return await dbProvider.getThisMonthTimeEntry(date);
  }
}
