import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/data/enums/language_details.dart';
import 'package:momentum_track/core/repositories/global_repository.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  final GlobalRepository _repository;
  AppSettingsCubit(this._repository)
    : super(
        AppSettingsState(
          languageDetails: LanguageDetails.english,
          settingsStatus: SettingsStatus.initial,
        ),
      );

  void initAppSettings() async {
    emit(state.copyWith(settingsStatus: SettingsStatus.loading));

    final LanguageDetails language = await _repository.readLocalizationInfo();

    emit(
      state.copyWith(
        settingsStatus: SettingsStatus.checked,
        languageDetails: language,
      ),
    );
  }

  void changeLanguage(LanguageDetails language) async {
    emit(state.copyWith(settingsStatus: SettingsStatus.loading));

    await _repository.saveLocalizationInfo(language);

    emit(
      state.copyWith(
        settingsStatus: SettingsStatus.checked,
        languageDetails: language,
      ),
    );
  }
}
