import 'package:momentum_track/core/data/enums/language_details.dart';
import 'package:momentum_track/core/data/models/month_dates.dart';
import 'package:momentum_track/core/data/providers/localization_provider.dart';
import 'package:momentum_track/core/data/services/global_date_service.dart';

class GlobalRepository {
  final GlobalDateService _globalDateService;
  final LocalizationProvider _localizationProvider;

  GlobalRepository(this._globalDateService, this._localizationProvider);

  MonthDates calculateFullMonthDates(DateTime? selectedDate) {
    return _globalDateService.calculateFullMonthDates(selectedDate);
  }

  Future<void> saveLocalizationInfo(LanguageDetails language) async {
    await _localizationProvider.saveLocalizationInfo(language);
  }

  Future<LanguageDetails> readLocalizationInfo() async {
    return await _localizationProvider.readLocalizationInfo();
  }
}
