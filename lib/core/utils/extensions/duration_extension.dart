extension DurationExtension on Duration? {
  String? get inHourAndMinutes {
    if (this == null) return 'No activities!';
    if (this!.inHours == 0 && this!.inMinutes == 0) return 'No activities!';
    return '${this?.inHours}h ${this?.inMinutes.remainder(60)}m';
  }
}
