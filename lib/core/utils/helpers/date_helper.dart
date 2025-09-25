class DateHelper {
  DateHelper._();

  // static DateTime today() {
  //   return DateTime.now().copyWith(
  //     hour: 0,
  //     minute: 0,
  //     second: 0,
  //     millisecond: 0,
  //     microsecond: 0,
  //   );
  // }

  static bool isToday(DateTime? date, DateTime today) {
    return date?.year == today.year &&
        date?.month == today.month &&
        date?.day == today.day;
  }
}
