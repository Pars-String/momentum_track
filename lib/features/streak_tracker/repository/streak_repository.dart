import 'package:momentum_track/core/utils/extensions/date_reset_extension.dart';
import 'package:momentum_track/features/streak_tracker/data/providers/streak_local_provider.dart';
import 'package:momentum_track/features/streak_tracker/data/services/streak_date_service.dart';

class StreakRepository {
  final StreakLocalProvider provider;
  final StreakDateService dateService;

  StreakRepository(this.provider, this.dateService);

  Map<int, List<DateTime>> buildActivityWeeks() {
    final monthDates = dateService.getPreviousMonthsUntilNow();
    final weeksMap = <int, List<DateTime>>{};

    int week = 1;
    for (final date in monthDates) {
      weeksMap.putIfAbsent(week, () => []).add(date);
      if (date.weekday == DateTime.sunday) week++;
    }

    return weeksMap;
  }

  Future<Map<DateTime, double>> buildStreakHeatMap(DateTime now) async {
    final heatMap = <DateTime, double>{};
    final timeEntries = await provider.updateStreakHeatMap(now);

    for (final entry in timeEntries) {
      if (entry.duration == null) continue;

      final DateTime date = entry.startTime.resetTime;

      if (heatMap.containsKey(date)) {
        heatMap[date] = heatMap[date]! + entry.duration!;
      } else {
        heatMap[date] = entry.duration!;
      }
    }

    return heatMap;
  }
}
