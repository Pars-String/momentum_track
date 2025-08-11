import 'package:momentum_track/core/data/models/month_dates.dart';
import 'package:shamsi_date/shamsi_date.dart';

class GlobalDateService {
  MonthDates calculateFullMonthDates(DateTime? selectedDate) {
    final DateTime now = selectedDate ?? DateTime.now();

    final Gregorian currentGregorian = Gregorian.fromDateTime(now);
    final List<Gregorian> gregorianDays = _getFullGregorianMonthDates(
      currentGregorian,
    );

    final Jalali currentJalali = currentGregorian.toJalali();
    final List<Jalali> jalaliDays = _getFullJalaliMonthDates(currentJalali);

    return MonthDates(
      gregorianDates: gregorianDays.map((d) => d.toDateTime()).toList(),
      jalaliDates: jalaliDays.map((d) => d.toDateTime()).toList(),
    );
  }
}

List<Gregorian> _getFullGregorianMonthDates(Gregorian date) {
  return List.generate(
    date.monthLength,
    (i) => Gregorian(date.year, date.month, i + 1),
  );
}

List<Jalali> _getFullJalaliMonthDates(Jalali date) {
  final int daysInMonth = date.monthLength;
  return List.generate(
    daysInMonth,
    (i) => Jalali(date.year, date.month, i + 1),
  );
}
