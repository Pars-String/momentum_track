import 'package:shamsi_date/shamsi_date.dart';

class StreakDateService {
  final DateTime Function() nowProvider;

  StreakDateService({DateTime Function()? nowProvider})
    : nowProvider = nowProvider ?? DateTime.now;

  List<DateTime> getPreviousMonthsUntilNow() {
    final List<DateTime> allDates = [];
    final now = nowProvider();
    DateTime calculatingDate = now.copyWith(year: now.year - 1, day: 1);

    for (int i = 13; i > 0; i--) {
      final gregorian = Gregorian.fromDateTime(calculatingDate);
      allDates.addAll(_getGregorianMonthDates(gregorian));
      calculatingDate = _goToNextMonth(calculatingDate);
    }
    return allDates;
  }

  List<DateTime> _getGregorianMonthDates(Gregorian date) {
    int daysInMonth = date.monthLength;
    int increment = 1;
    final today = nowProvider();

    if (_isSameMonth(date.toDateTime(), today)) {
      daysInMonth = today.day;
    }
    if (_isSameMonth(date.toDateTime(), today.copyWith(year: today.year - 1))) {
      daysInMonth -= today.day;
      increment = today.day + 1;
    }

    return List.generate(
      daysInMonth,
      (i) => Gregorian(date.year, date.month, i + increment).toDateTime(),
    );
  }

  DateTime _goToNextMonth(DateTime date) => date.month == 12
      ? DateTime(date.year + 1, 1, 1)
      : DateTime(date.year, date.month + 1, 1);

  bool _isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;
}
