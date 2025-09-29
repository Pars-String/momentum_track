import 'package:intl/intl_standalone.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/data/enums/language_details.dart';
import 'package:momentum_track/core/data/services/preferences_service.dart';

class LocalizationProvider {
  final PreferencesService _sharedPreferences;

  LocalizationProvider(this._sharedPreferences);

  Future<void> saveLocalizationInfo(LanguageDetails language) async {
    final String localeInfo = language.localeKey;

    await _sharedPreferences.write<String>(
      AppArguments.languageCode,
      localeInfo,
    );
  }

  Future<LanguageDetails> readLocalizationInfo() async {
    final String? localeInfo = await _sharedPreferences.read<String>(
      AppArguments.languageCode,
    );

    final Map<String, LanguageDetails> localeMap = {
      LanguageDetails.english.localeKey: LanguageDetails.english,
      LanguageDetails.persian.localeKey: LanguageDetails.persian,
    };

    final String systemLocale = await findSystemLocale();
    final LanguageDetails systemLanguageStatus =
        systemLocale.split('_').first == LanguageDetails.persian.localeKey
        ? LanguageDetails.persian
        : LanguageDetails.english;

    /// systemLocale is en_US if region is USA and language is English
    /// systemLocale is de_DE if region is Germany and language is German
    /// systemLocale is en_DE if region is Germany and language is English

    return localeMap[localeInfo] ?? systemLanguageStatus;
  }
}
