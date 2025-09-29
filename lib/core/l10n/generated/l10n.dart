// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `January`
  String get gregorian_month_january {
    return Intl.message(
      'January',
      name: 'gregorian_month_january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get gregorian_month_february {
    return Intl.message(
      'February',
      name: 'gregorian_month_february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get gregorian_month_march {
    return Intl.message(
      'March',
      name: 'gregorian_month_march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get gregorian_month_april {
    return Intl.message(
      'April',
      name: 'gregorian_month_april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get gregorian_month_may {
    return Intl.message('May', name: 'gregorian_month_may', desc: '', args: []);
  }

  /// `June`
  String get gregorian_month_june {
    return Intl.message(
      'June',
      name: 'gregorian_month_june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get gregorian_month_july {
    return Intl.message(
      'July',
      name: 'gregorian_month_july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get gregorian_month_august {
    return Intl.message(
      'August',
      name: 'gregorian_month_august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get gregorian_month_september {
    return Intl.message(
      'September',
      name: 'gregorian_month_september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get gregorian_month_october {
    return Intl.message(
      'October',
      name: 'gregorian_month_october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get gregorian_month_november {
    return Intl.message(
      'November',
      name: 'gregorian_month_november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get gregorian_month_december {
    return Intl.message(
      'December',
      name: 'gregorian_month_december',
      desc: '',
      args: [],
    );
  }

  /// `Farvardin`
  String get jalali_month_farvardin {
    return Intl.message(
      'Farvardin',
      name: 'jalali_month_farvardin',
      desc: '',
      args: [],
    );
  }

  /// `Ordibehesht`
  String get jalali_month_ordibehesht {
    return Intl.message(
      'Ordibehesht',
      name: 'jalali_month_ordibehesht',
      desc: '',
      args: [],
    );
  }

  /// `Khordad`
  String get jalali_month_khordad {
    return Intl.message(
      'Khordad',
      name: 'jalali_month_khordad',
      desc: '',
      args: [],
    );
  }

  /// `Tir`
  String get jalali_month_tir {
    return Intl.message('Tir', name: 'jalali_month_tir', desc: '', args: []);
  }

  /// `Mordad`
  String get jalali_month_mordad {
    return Intl.message(
      'Mordad',
      name: 'jalali_month_mordad',
      desc: '',
      args: [],
    );
  }

  /// `Shahrivar`
  String get jalali_month_shahrivar {
    return Intl.message(
      'Shahrivar',
      name: 'jalali_month_shahrivar',
      desc: '',
      args: [],
    );
  }

  /// `Mehr`
  String get jalali_month_mehr {
    return Intl.message('Mehr', name: 'jalali_month_mehr', desc: '', args: []);
  }

  /// `Aban`
  String get jalali_month_aban {
    return Intl.message('Aban', name: 'jalali_month_aban', desc: '', args: []);
  }

  /// `Azar`
  String get jalali_month_azar {
    return Intl.message('Azar', name: 'jalali_month_azar', desc: '', args: []);
  }

  /// `Dey`
  String get jalali_month_dey {
    return Intl.message('Dey', name: 'jalali_month_dey', desc: '', args: []);
  }

  /// `Bahman`
  String get jalali_month_bahman {
    return Intl.message(
      'Bahman',
      name: 'jalali_month_bahman',
      desc: '',
      args: [],
    );
  }

  /// `Esfand`
  String get jalali_month_esfand {
    return Intl.message(
      'Esfand',
      name: 'jalali_month_esfand',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get weekday_saturday {
    return Intl.message(
      'Saturday',
      name: 'weekday_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get weekday_sunday {
    return Intl.message('Sunday', name: 'weekday_sunday', desc: '', args: []);
  }

  /// `Monday`
  String get weekday_monday {
    return Intl.message('Monday', name: 'weekday_monday', desc: '', args: []);
  }

  /// `Tuesday`
  String get weekday_tuesday {
    return Intl.message('Tuesday', name: 'weekday_tuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get weekday_wednesday {
    return Intl.message(
      'Wednesday',
      name: 'weekday_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get weekday_thursday {
    return Intl.message(
      'Thursday',
      name: 'weekday_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get weekday_friday {
    return Intl.message('Friday', name: 'weekday_friday', desc: '', args: []);
  }

  /// `Sa`
  String get weekday_saturday_code {
    return Intl.message(
      'Sa',
      name: 'weekday_saturday_code',
      desc: '',
      args: [],
    );
  }

  /// `Su`
  String get weekday_sunday_code {
    return Intl.message('Su', name: 'weekday_sunday_code', desc: '', args: []);
  }

  /// `Mo`
  String get weekday_monday_code {
    return Intl.message('Mo', name: 'weekday_monday_code', desc: '', args: []);
  }

  /// `Tu`
  String get weekday_tuesday_code {
    return Intl.message('Tu', name: 'weekday_tuesday_code', desc: '', args: []);
  }

  /// `We`
  String get weekday_wednesday_code {
    return Intl.message(
      'We',
      name: 'weekday_wednesday_code',
      desc: '',
      args: [],
    );
  }

  /// `Th`
  String get weekday_thursday_code {
    return Intl.message(
      'Th',
      name: 'weekday_thursday_code',
      desc: '',
      args: [],
    );
  }

  /// `Fr`
  String get weekday_friday_code {
    return Intl.message('Fr', name: 'weekday_friday_code', desc: '', args: []);
  }

  /// `Gregorian`
  String get calendarType_gregorian {
    return Intl.message(
      'Gregorian',
      name: 'calendarType_gregorian',
      desc: '',
      args: [],
    );
  }

  /// `Persian`
  String get calendarType_jalali {
    return Intl.message(
      'Persian',
      name: 'calendarType_jalali',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get sideMenuTitle_calendar {
    return Intl.message(
      'Calendar',
      name: 'sideMenuTitle_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get sideMenuTitle_projects {
    return Intl.message(
      'Projects',
      name: 'sideMenuTitle_projects',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get sideMenuTitle_settings {
    return Intl.message(
      'Settings',
      name: 'sideMenuTitle_settings',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get common_inProgress {
    return Intl.message(
      'In progress',
      name: 'common_inProgress',
      desc: '',
      args: [],
    );
  }

  /// `No description`
  String get common_noDescription {
    return Intl.message(
      'No description',
      name: 'common_noDescription',
      desc: '',
      args: [],
    );
  }

  /// `Start at`
  String get common_startAt {
    return Intl.message('Start at', name: 'common_startAt', desc: '', args: []);
  }

  /// `End at`
  String get common_endAt {
    return Intl.message('End at', name: 'common_endAt', desc: '', args: []);
  }

  /// `Please Wait`
  String get common_pleaseWait {
    return Intl.message(
      'Please Wait',
      name: 'common_pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Your report exported successfully`
  String get toast_reportExportedSuccess {
    return Intl.message(
      'Your report exported successfully',
      name: 'toast_reportExportedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Email address copied to clipboard`
  String get toast_copyEmailToClipboard {
    return Intl.message(
      'Email address copied to clipboard',
      name: 'toast_copyEmailToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Backup database successfully`
  String get toast_backupDbSuccess {
    return Intl.message(
      'Backup database successfully',
      name: 'toast_backupDbSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Delete all data successfully`
  String get toast_deleteDbSuccess {
    return Intl.message(
      'Delete all data successfully',
      name: 'toast_deleteDbSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Recover all data successfully`
  String get toast_recoverDbSuccess {
    return Intl.message(
      'Recover all data successfully',
      name: 'toast_recoverDbSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get toast_success_title {
    return Intl.message(
      'Successful',
      name: 'toast_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get toast_failure_title {
    return Intl.message(
      'Failure',
      name: 'toast_failure_title',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again`
  String get toast_failure_content {
    return Intl.message(
      'Something went wrong, please try again',
      name: 'toast_failure_content',
      desc: '',
      args: [],
    );
  }

  /// `Add Project`
  String get tooltip_addProject {
    return Intl.message(
      'Add Project',
      name: 'tooltip_addProject',
      desc: '',
      args: [],
    );
  }

  /// `Add Time Entry`
  String get tooltip_addTimeEntry {
    return Intl.message(
      'Add Time Entry',
      name: 'tooltip_addTimeEntry',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get button_generate {
    return Intl.message(
      'Generate',
      name: 'button_generate',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message('Cancel', name: 'button_cancel', desc: '', args: []);
  }

  /// `Delete`
  String get button_delete {
    return Intl.message('Delete', name: 'button_delete', desc: '', args: []);
  }

  /// `Submit`
  String get button_submit {
    return Intl.message('Submit', name: 'button_submit', desc: '', args: []);
  }

  /// `Continue`
  String get button_continue {
    return Intl.message(
      'Continue',
      name: 'button_continue',
      desc: '',
      args: [],
    );
  }

  /// `Restore Database`
  String get button_restoreDatabase {
    return Intl.message(
      'Restore Database',
      name: 'button_restoreDatabase',
      desc: '',
      args: [],
    );
  }

  /// `Create Backup`
  String get button_createBackup {
    return Intl.message(
      'Create Backup',
      name: 'button_createBackup',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Data`
  String get button_deleteData {
    return Intl.message(
      'Delete All Data',
      name: 'button_deleteData',
      desc: '',
      args: [],
    );
  }

  /// `Save as Excel (this month)`
  String get button_saveThisMonthAsExcel {
    return Intl.message(
      'Save as Excel (this month)',
      name: 'button_saveThisMonthAsExcel',
      desc: '',
      args: [],
    );
  }

  /// `Save as Excel (custom date)`
  String get button_saveSelectedMonthAsExcel {
    return Intl.message(
      'Save as Excel (custom date)',
      name: 'button_saveSelectedMonthAsExcel',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get button_changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'button_changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Report an Issue`
  String get button_reportIssue {
    return Intl.message(
      'Report an Issue',
      name: 'button_reportIssue',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get button_close {
    return Intl.message('Close', name: 'button_close', desc: '', args: []);
  }

  /// `Contact Info`
  String get button_contactInfo {
    return Intl.message(
      'Contact Info',
      name: 'button_contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Current Month`
  String get button_currentMonth {
    return Intl.message(
      'Current Month',
      name: 'button_currentMonth',
      desc: '',
      args: [],
    );
  }

  /// `Please select an end date`
  String get validator_selectEndDate {
    return Intl.message(
      'Please select an end date',
      name: 'validator_selectEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Please select a start date`
  String get validator_selectStartDate {
    return Intl.message(
      'Please select a start date',
      name: 'validator_selectStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a project name`
  String get validator_enterProjectName {
    return Intl.message(
      'Please enter a project name',
      name: 'validator_enterProjectName',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get validator_required {
    return Intl.message(
      'Required',
      name: 'validator_required',
      desc: '',
      args: [],
    );
  }

  /// `Select end date`
  String get fieldLabel_endDate {
    return Intl.message(
      'Select end date',
      name: 'fieldLabel_endDate',
      desc: '',
      args: [],
    );
  }

  /// `Select start date`
  String get fieldLabel_startDate {
    return Intl.message(
      'Select start date',
      name: 'fieldLabel_startDate',
      desc: '',
      args: [],
    );
  }

  /// `Project Name`
  String get fieldLabel_projectName {
    return Intl.message(
      'Project Name',
      name: 'fieldLabel_projectName',
      desc: '',
      args: [],
    );
  }

  /// `Start at`
  String get fieldLabel_startAt {
    return Intl.message(
      'Start at',
      name: 'fieldLabel_startAt',
      desc: '',
      args: [],
    );
  }

  /// `End at`
  String get fieldLabel_endAt {
    return Intl.message('End at', name: 'fieldLabel_endAt', desc: '', args: []);
  }

  /// `time`
  String get fieldLabel_time {
    return Intl.message('time', name: 'fieldLabel_time', desc: '', args: []);
  }

  /// `Choose your Project`
  String get fieldHint_chooseProject {
    return Intl.message(
      'Choose your Project',
      name: 'fieldHint_chooseProject',
      desc: '',
      args: [],
    );
  }

  /// `Enter description (optional)`
  String get fieldHint_enterDescription {
    return Intl.message(
      'Enter description (optional)',
      name: 'fieldHint_enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Export Report`
  String get generateReport_exportDialogBox_title {
    return Intl.message(
      'Export Report',
      name: 'generateReport_exportDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `Add Time Entry`
  String get timeEntryDialogBox_title {
    return Intl.message(
      'Add Time Entry',
      name: 'timeEntryDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `Delete Project`
  String get projects_deleteProjectDialogBox_title {
    return Intl.message(
      'Delete Project',
      name: 'projects_deleteProjectDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete {projectName} project?\nThis action cannot be undone and will delete all time entries related to this project.`
  String projects_deleteProjectDialogBox_content(String projectName) {
    return Intl.message(
      'Do you really want to delete $projectName project?\nThis action cannot be undone and will delete all time entries related to this project.',
      name: 'projects_deleteProjectDialogBox_content',
      desc: 'project name',
      args: [projectName],
    );
  }

  /// `{line, select, line1{Help us make this app better!} line2{Share your thoughts, report problems, or suggest new features.} line3{You can contact us anytime via email or send me a message on LinkedIn.} other{}}`
  String contactAndSupport_contactDialogBox_contents(String line) {
    return Intl.select(
      line,
      {
        'line1': 'Help us make this app better!',
        'line2':
            'Share your thoughts, report problems, or suggest new features.',
        'line3':
            'You can contact us anytime via email or send me a message on LinkedIn.',
        'other': '',
      },
      name: 'contactAndSupport_contactDialogBox_contents',
      desc: 'handle description lines',
      args: [line],
    );
  }

  /// `{title, select, true{Add New Project} false{Edit Project} other{}}`
  String projects_addOrEditProjectDialogBox_title(String title) {
    return Intl.select(
      title,
      {'true': 'Add New Project', 'false': 'Edit Project', 'other': ''},
      name: 'projects_addOrEditProjectDialogBox_title',
      desc: 'add or edit project title',
      args: [title],
    );
  }

  /// `Create at `
  String get projects_projectInfoDialogBox_createAt {
    return Intl.message(
      'Create at ',
      name: 'projects_projectInfoDialogBox_createAt',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get manageDatabase_backupDialogBox_title {
    return Intl.message(
      'Backup',
      name: 'manageDatabase_backupDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a directory.`
  String get manageDatabase_backupDialogBox_chooseDir {
    return Intl.message(
      'Please choose a directory.',
      name: 'manageDatabase_backupDialogBox_chooseDir',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get manageDatabase_deleteDialogBox_title {
    return Intl.message(
      'Warning',
      name: 'manageDatabase_deleteDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `Do you really wanna delete all data?`
  String get manageDatabase_deleteDialogBox_content {
    return Intl.message(
      'Do you really wanna delete all data?',
      name: 'manageDatabase_deleteDialogBox_content',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get manageDatabase_recoverDialogBox_title {
    return Intl.message(
      'Notice',
      name: 'manageDatabase_recoverDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `This action will be delete all your current data and replace them with your backup data that you provide.`
  String get manageDatabase_recoverDialogBox_content {
    return Intl.message(
      'This action will be delete all your current data and replace them with your backup data that you provide.',
      name: 'manageDatabase_recoverDialogBox_content',
      desc: '',
      args: [],
    );
  }

  /// `Delete Time Entry`
  String get deleteEventButton_deleteDialogBox_title {
    return Intl.message(
      'Delete Time Entry',
      name: 'deleteEventButton_deleteDialogBox_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this time entry?`
  String get deleteEventButton_deleteDialogBox_content {
    return Intl.message(
      'Are you sure you want to delete this time entry?',
      name: 'deleteEventButton_deleteDialogBox_content',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load date details`
  String get dateDetailsScreen_failure {
    return Intl.message(
      'Failed to load date details',
      name: 'dateDetailsScreen_failure',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load projects`
  String get projectsScreen_failure {
    return Intl.message(
      'Failed to load projects',
      name: 'projectsScreen_failure',
      desc: '',
      args: [],
    );
  }

  /// `No projects found`
  String get projectsScreen_emptyList {
    return Intl.message(
      'No projects found',
      name: 'projectsScreen_emptyList',
      desc: '',
      args: [],
    );
  }

  /// `Start from `
  String get projectsScreen_startFrom {
    return Intl.message(
      'Start from ',
      name: 'projectsScreen_startFrom',
      desc: '',
      args: [],
    );
  }

  /// `Total duration  `
  String get projectsScreen_totalDuration {
    return Intl.message(
      'Total duration  ',
      name: 'projectsScreen_totalDuration',
      desc: '',
      args: [],
    );
  }

  /// `calculating`
  String get projectsScreen_calculating {
    return Intl.message(
      'calculating',
      name: 'projectsScreen_calculating',
      desc: '',
      args: [],
    );
  }

  /// `Error calculating duration`
  String get projectsScreen_calculatingFailure {
    return Intl.message(
      'Error calculating duration',
      name: 'projectsScreen_calculatingFailure',
      desc: '',
      args: [],
    );
  }

  /// `No activities!`
  String get projectsScreen_noActivities {
    return Intl.message(
      'No activities!',
      name: 'projectsScreen_noActivities',
      desc: '',
      args: [],
    );
  }

  /// `No time entries found`
  String get projectDetailsScreen_emptyList {
    return Intl.message(
      'No time entries found',
      name: 'projectDetailsScreen_emptyList',
      desc: '',
      args: [],
    );
  }

  /// `Fetching Data...`
  String get projectDetailsScreen_fetchData {
    return Intl.message(
      'Fetching Data...',
      name: 'projectDetailsScreen_fetchData',
      desc: '',
      args: [],
    );
  }

  /// `Database Settings`
  String get settingsScreen_database_title {
    return Intl.message(
      'Database Settings',
      name: 'settingsScreen_database_title',
      desc: '',
      args: [],
    );
  }

  /// `Generate Report`
  String get settingsScreen_generateReport_title {
    return Intl.message(
      'Generate Report',
      name: 'settingsScreen_generateReport_title',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get settingsScreen_appSettings_title {
    return Intl.message(
      'App Settings',
      name: 'settingsScreen_appSettings_title',
      desc: '',
      args: [],
    );
  }

  /// `Contact & Support`
  String get settingsScreen_contact_title {
    return Intl.message(
      'Contact & Support',
      name: 'settingsScreen_contact_title',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get calendarScreen_today {
    return Intl.message(
      'Today',
      name: 'calendarScreen_today',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load overview`
  String get calendarScreen_failure {
    return Intl.message(
      'Failed to load overview',
      name: 'calendarScreen_failure',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
