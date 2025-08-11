import 'package:momentum_track/core/data/models/last_month_day.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalculatingHelper {
  CalculatingHelper._();

  static double convertDurationToHours({
    required DateTime startAt,
    required DateTime endAt,
  }) {
    Duration diff = endAt.difference(startAt);
    return diff.inMinutes / 60.0;
  }

  static Duration convertHoursToDuration(double hours) {
    return Duration(seconds: (hours * 3600).round());
  }

  static DateTime today() {
    return DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  static LastMonthDay calculateLastDayOfMonth(DateTime? selectedDate) {
    final DateTime now = selectedDate ?? DateTime.now();

    final Gregorian currentGregorian = Gregorian.fromDateTime(now);
    final int daysInGregorianMonth = currentGregorian.monthLength;

    final Jalali currentJalali = currentGregorian.toJalali();
    final int daysInJalaliMonth = currentJalali.monthLength;

    return LastMonthDay(
      gregorianLastDay: Gregorian(
        currentGregorian.year,
        currentGregorian.month,
        daysInGregorianMonth,
      ).toDateTime(),
      jalaliLastDay: Jalali(
        currentJalali.year,
        currentJalali.month,
        daysInJalaliMonth,
      ).toDateTime(),
    );
  }
}
