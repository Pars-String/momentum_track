import 'package:momentum_track/core/l10n/generated/l10n.dart';

extension DurationExtension on Duration? {
  String? get inHourAndMinutes {
    if (this == null) return S.current.projectsScreen_noActivities;
    if (this!.inHours == 0 && this!.inMinutes == 0) {
      return S.current.projectsScreen_noActivities;
    }
    return '${this?.inHours}h ${this?.inMinutes.remainder(60)}m';
  }
}
