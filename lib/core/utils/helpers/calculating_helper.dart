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
}
