import 'package:intl/intl.dart';

extension DateFormatterExtension on DateTime? {
  String? get monthWeekdayDay {
    if (this == null) return null;
    return DateFormat.MMMMEEEEd().format(this!);
  }

  String? get monthTitle {
    if (this == null) return null;
    return DateFormat('MMMM').format(this!);
  }

  String? get yearMonthDay {
    if (this == null) return null;
    return DateFormat('yyyy-MM-dd').format(this!);
  }

  String? get hmm {
    if (this == null) return null;
    return DateFormat('h:mm a').format(this!);
  }

  String? get yearMonthDayShort {
    if (this == null) return null;
    return DateFormat.yMMMMd().format(this!);
  }

  String? get dayMonthShort {
    if (this == null) return null;
    return DateFormat('dd, MMMM').format(this!);
  }

  String? get weekdayTitleShort {
    if (this == null) return null;
    return DateFormat('EEEE').format(this!);
  }

  String? get weekdayTitle {
    if (this == null) return null;
    return DateFormat('EEE').format(this!);
  }
}
