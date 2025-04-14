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

  static DateTime today() {
    return DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
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
