import 'package:flutter/foundation.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalculatingHelper {
  CalculatingHelper._();

  static double calculateDuration({
    required DateTime startAt,
    required DateTime endAt,
  }) {
    Duration diff = endAt.difference(startAt);

    // Convert duration to double (hours)
    return diff.inMinutes / 60.0;
  }

  static Future<Duration> calculateDurationFrom(
    List<TimeEntry> timeEntries,
    int projectID,
  ) async {
    final args = (timeEntries, projectID);
    Duration totalDuration = await compute(_calculateDurationFrom, args);

    return totalDuration;
  }

  static Duration convertDoubleToDuration(double hours) {
    // Convert hours back to seconds and create a Duration
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

  static List<DateTime> calculateWeekDates(DateTime? selectedDate) {
    final DateTime now = selectedDate ?? DateTime.now();
    final List<DateTime> dateList = [];
    final DateTime startOfWeek = now.subtract(
      Duration(days: (now.weekday - 1)),
    );

    int i = 0;
    while (i < 7) {
      final DateTime date = startOfWeek.add(Duration(days: i));
      dateList.add(
        date.copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ),
      );
      i++;
    }

    return dateList;
  }

  static ({List<DateTime> gregorianDates, List<DateTime> jalaliDates})
  calculateMonthDates(DateTime? selectedDate) {
    final DateTime now = selectedDate ?? DateTime.now();

    final Gregorian currentGregorian = Gregorian.fromDateTime(now);
    final List<Gregorian> gregorianDays = _getGregorianMonthDates(
      currentGregorian,
    );

    final Jalali currentJalali = currentGregorian.toJalali();
    final List<Jalali> jalaliDays = _getJalaliMonthDates(currentJalali);

    return (
      gregorianDates: gregorianDays.map((d) => d.toDateTime()).toList(),
      jalaliDates: jalaliDays.map((d) => d.toDateTime()).toList(),
    );
  }

  static ({DateTime gregorianLastDay, DateTime jalaliLastDay})
  calculateLastDayOfMonth(DateTime? selectedDate) {
    final DateTime now = selectedDate ?? DateTime.now();

    final Gregorian currentGregorian = Gregorian.fromDateTime(now);
    final int daysInGregorianMonth = currentGregorian.monthLength;

    final Jalali currentJalali = currentGregorian.toJalali();
    final int daysInJalaliMonth = currentJalali.monthLength;

    return (
      gregorianLastDay:
          Gregorian(
            currentGregorian.year,
            currentGregorian.month,
            daysInGregorianMonth,
          ).toDateTime(),
      jalaliLastDay:
          Jalali(
            currentJalali.year,
            currentJalali.month,
            daysInJalaliMonth,
          ).toDateTime(),
    );
  }
}

List<Gregorian> _getGregorianMonthDates(Gregorian date) {
  final int daysInMonth = date.monthLength;
  return List.generate(
    daysInMonth,
    (i) => Gregorian(date.year, date.month, i + 1),
  );
}

List<Jalali> _getJalaliMonthDates(Jalali date) {
  final int daysInMonth = date.monthLength;
  return List.generate(
    daysInMonth,
    (i) => Jalali(date.year, date.month, i + 1),
  );
}

Duration _calculateDurationFrom((List<TimeEntry>, int) args) {
  final timeEntries = args.$1;
  final projectID = args.$2;
  final listedEntries =
      timeEntries
          .where((timeEntry) => timeEntry.projectId == projectID)
          .toList();

  Duration totalDuration = Duration.zero;
  for (var timeEntry in listedEntries) {
    totalDuration +=
        timeEntry.duration != null
            ? Duration(seconds: (timeEntry.duration! * 3600).round())
            : Duration.zero;
  }

  return totalDuration;
}
