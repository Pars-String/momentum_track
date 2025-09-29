// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_settings_cubit.dart';

enum SettingsStatus { initial, loading, checked }

class AppSettingsState extends Equatable {
  final SettingsStatus settingsStatus;
  final LanguageDetails languageDetails;
  const AppSettingsState({
    required this.settingsStatus,
    required this.languageDetails,
  });

  @override
  List<Object> get props => [settingsStatus, languageDetails];

  AppSettingsState copyWith({
    SettingsStatus? settingsStatus,
    LanguageDetails? languageDetails,
  }) {
    return AppSettingsState(
      settingsStatus: settingsStatus ?? this.settingsStatus,
      languageDetails: languageDetails ?? this.languageDetails,
    );
  }
}
