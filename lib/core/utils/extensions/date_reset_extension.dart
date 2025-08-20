extension DateResetExtension on DateTime {
  DateTime get resetTime =>
      copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
}
