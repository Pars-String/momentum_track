import 'dart:ui';

enum LanguageDetails {
  english(locale: Locale('en', ''), localeKey: 'en', title: 'English (EN)'),
  persian(locale: Locale('fa', ''), localeKey: 'fa', title: 'فارسی (FA)');

  const LanguageDetails({
    required this.locale,
    required this.localeKey,
    required this.title,
  });

  final Locale locale;
  final String localeKey;
  final String title;
}
