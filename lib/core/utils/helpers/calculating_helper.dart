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
}
