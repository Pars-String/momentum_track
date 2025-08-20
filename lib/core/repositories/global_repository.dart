import 'package:momentum_track/core/data/models/month_dates.dart';
import 'package:momentum_track/core/data/services/global_date_service.dart';

class GlobalRepository {
  final GlobalDateService _globalDateService;

  GlobalRepository(this._globalDateService);

  MonthDates calculateFullMonthDates(DateTime? selectedDate) {
    return _globalDateService.calculateFullMonthDates(selectedDate);
  }
}
