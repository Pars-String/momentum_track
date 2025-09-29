// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(line) =>
      "${Intl.select(line, {'line1': 'Help us make this app better!', 'line2': 'Share your thoughts, report problems, or suggest new features.', 'line3': 'You can contact us anytime via email or send me a message on LinkedIn.', 'other': ''})}";

  static String m1(title) =>
      "${Intl.select(title, {'true': 'Add New Project', 'false': 'Edit Project', 'other': ''})}";

  static String m2(projectName) =>
      "Do you really want to delete ${projectName} project?\nThis action cannot be undone and will delete all time entries related to this project.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "button_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "button_changeLanguage": MessageLookupByLibrary.simpleMessage(
      "Change Language",
    ),
    "button_close": MessageLookupByLibrary.simpleMessage("Close"),
    "button_contactInfo": MessageLookupByLibrary.simpleMessage("Contact Info"),
    "button_continue": MessageLookupByLibrary.simpleMessage("Continue"),
    "button_createBackup": MessageLookupByLibrary.simpleMessage(
      "Create Backup",
    ),
    "button_currentMonth": MessageLookupByLibrary.simpleMessage(
      "Current Month",
    ),
    "button_delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "button_deleteData": MessageLookupByLibrary.simpleMessage(
      "Delete All Data",
    ),
    "button_generate": MessageLookupByLibrary.simpleMessage("Generate"),
    "button_reportIssue": MessageLookupByLibrary.simpleMessage(
      "Report an Issue",
    ),
    "button_restoreDatabase": MessageLookupByLibrary.simpleMessage(
      "Restore Database",
    ),
    "button_saveSelectedMonthAsExcel": MessageLookupByLibrary.simpleMessage(
      "Save as Excel (custom date)",
    ),
    "button_saveThisMonthAsExcel": MessageLookupByLibrary.simpleMessage(
      "Save as Excel (this month)",
    ),
    "button_submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "calendarScreen_failure": MessageLookupByLibrary.simpleMessage(
      "Failed to load overview",
    ),
    "calendarScreen_today": MessageLookupByLibrary.simpleMessage("Today"),
    "calendarType_gregorian": MessageLookupByLibrary.simpleMessage("Gregorian"),
    "calendarType_jalali": MessageLookupByLibrary.simpleMessage("Persian"),
    "common_endAt": MessageLookupByLibrary.simpleMessage("End at"),
    "common_inProgress": MessageLookupByLibrary.simpleMessage("In progress"),
    "common_noDescription": MessageLookupByLibrary.simpleMessage(
      "No description",
    ),
    "common_pleaseWait": MessageLookupByLibrary.simpleMessage("Please Wait"),
    "common_startAt": MessageLookupByLibrary.simpleMessage("Start at"),
    "contactAndSupport_contactDialogBox_contents": m0,
    "dateDetailsScreen_failure": MessageLookupByLibrary.simpleMessage(
      "Failed to load date details",
    ),
    "deleteEventButton_deleteDialogBox_content":
        MessageLookupByLibrary.simpleMessage(
          "Are you sure you want to delete this time entry?",
        ),
    "deleteEventButton_deleteDialogBox_title":
        MessageLookupByLibrary.simpleMessage("Delete Time Entry"),
    "fieldHint_chooseProject": MessageLookupByLibrary.simpleMessage(
      "Choose your Project",
    ),
    "fieldHint_enterDescription": MessageLookupByLibrary.simpleMessage(
      "Enter description (optional)",
    ),
    "fieldLabel_endAt": MessageLookupByLibrary.simpleMessage("End at"),
    "fieldLabel_endDate": MessageLookupByLibrary.simpleMessage(
      "Select end date",
    ),
    "fieldLabel_projectName": MessageLookupByLibrary.simpleMessage(
      "Project Name",
    ),
    "fieldLabel_startAt": MessageLookupByLibrary.simpleMessage("Start at"),
    "fieldLabel_startDate": MessageLookupByLibrary.simpleMessage(
      "Select start date",
    ),
    "fieldLabel_time": MessageLookupByLibrary.simpleMessage("time"),
    "generateReport_exportDialogBox_title":
        MessageLookupByLibrary.simpleMessage("Export Report"),
    "gregorian_month_april": MessageLookupByLibrary.simpleMessage("April"),
    "gregorian_month_august": MessageLookupByLibrary.simpleMessage("August"),
    "gregorian_month_december": MessageLookupByLibrary.simpleMessage(
      "December",
    ),
    "gregorian_month_february": MessageLookupByLibrary.simpleMessage(
      "February",
    ),
    "gregorian_month_january": MessageLookupByLibrary.simpleMessage("January"),
    "gregorian_month_july": MessageLookupByLibrary.simpleMessage("July"),
    "gregorian_month_june": MessageLookupByLibrary.simpleMessage("June"),
    "gregorian_month_march": MessageLookupByLibrary.simpleMessage("March"),
    "gregorian_month_may": MessageLookupByLibrary.simpleMessage("May"),
    "gregorian_month_november": MessageLookupByLibrary.simpleMessage(
      "November",
    ),
    "gregorian_month_october": MessageLookupByLibrary.simpleMessage("October"),
    "gregorian_month_september": MessageLookupByLibrary.simpleMessage(
      "September",
    ),
    "jalali_month_aban": MessageLookupByLibrary.simpleMessage("Aban"),
    "jalali_month_azar": MessageLookupByLibrary.simpleMessage("Azar"),
    "jalali_month_bahman": MessageLookupByLibrary.simpleMessage("Bahman"),
    "jalali_month_dey": MessageLookupByLibrary.simpleMessage("Dey"),
    "jalali_month_esfand": MessageLookupByLibrary.simpleMessage("Esfand"),
    "jalali_month_farvardin": MessageLookupByLibrary.simpleMessage("Farvardin"),
    "jalali_month_khordad": MessageLookupByLibrary.simpleMessage("Khordad"),
    "jalali_month_mehr": MessageLookupByLibrary.simpleMessage("Mehr"),
    "jalali_month_mordad": MessageLookupByLibrary.simpleMessage("Mordad"),
    "jalali_month_ordibehesht": MessageLookupByLibrary.simpleMessage(
      "Ordibehesht",
    ),
    "jalali_month_shahrivar": MessageLookupByLibrary.simpleMessage("Shahrivar"),
    "jalali_month_tir": MessageLookupByLibrary.simpleMessage("Tir"),
    "manageDatabase_backupDialogBox_chooseDir":
        MessageLookupByLibrary.simpleMessage("Please choose a directory."),
    "manageDatabase_backupDialogBox_title":
        MessageLookupByLibrary.simpleMessage("Backup"),
    "manageDatabase_deleteDialogBox_content":
        MessageLookupByLibrary.simpleMessage(
          "Do you really wanna delete all data?",
        ),
    "manageDatabase_deleteDialogBox_title":
        MessageLookupByLibrary.simpleMessage("Warning"),
    "manageDatabase_recoverDialogBox_content": MessageLookupByLibrary.simpleMessage(
      "This action will be delete all your current data and replace them with your backup data that you provide.",
    ),
    "manageDatabase_recoverDialogBox_title":
        MessageLookupByLibrary.simpleMessage("Notice"),
    "projectDetailsScreen_emptyList": MessageLookupByLibrary.simpleMessage(
      "No time entries found",
    ),
    "projectDetailsScreen_fetchData": MessageLookupByLibrary.simpleMessage(
      "Fetching Data...",
    ),
    "projectsScreen_calculating": MessageLookupByLibrary.simpleMessage(
      "calculating",
    ),
    "projectsScreen_calculatingFailure": MessageLookupByLibrary.simpleMessage(
      "Error calculating duration",
    ),
    "projectsScreen_emptyList": MessageLookupByLibrary.simpleMessage(
      "No projects found",
    ),
    "projectsScreen_failure": MessageLookupByLibrary.simpleMessage(
      "Failed to load projects",
    ),
    "projectsScreen_noActivities": MessageLookupByLibrary.simpleMessage(
      "No activities!",
    ),
    "projectsScreen_startFrom": MessageLookupByLibrary.simpleMessage(
      "Start from ",
    ),
    "projectsScreen_totalDuration": MessageLookupByLibrary.simpleMessage(
      "Total duration  ",
    ),
    "projects_addOrEditProjectDialogBox_title": m1,
    "projects_deleteProjectDialogBox_content": m2,
    "projects_deleteProjectDialogBox_title":
        MessageLookupByLibrary.simpleMessage("Delete Project"),
    "projects_projectInfoDialogBox_createAt":
        MessageLookupByLibrary.simpleMessage("Create at "),
    "settingsScreen_appSettings_title": MessageLookupByLibrary.simpleMessage(
      "App Settings",
    ),
    "settingsScreen_contact_title": MessageLookupByLibrary.simpleMessage(
      "Contact & Support",
    ),
    "settingsScreen_database_title": MessageLookupByLibrary.simpleMessage(
      "Database Settings",
    ),
    "settingsScreen_generateReport_title": MessageLookupByLibrary.simpleMessage(
      "Generate Report",
    ),
    "sideMenuTitle_calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "sideMenuTitle_projects": MessageLookupByLibrary.simpleMessage("Projects"),
    "sideMenuTitle_settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "timeEntryDialogBox_title": MessageLookupByLibrary.simpleMessage(
      "Add Time Entry",
    ),
    "toast_backupDbSuccess": MessageLookupByLibrary.simpleMessage(
      "Backup database successfully",
    ),
    "toast_copyEmailToClipboard": MessageLookupByLibrary.simpleMessage(
      "Email address copied to clipboard",
    ),
    "toast_deleteDbSuccess": MessageLookupByLibrary.simpleMessage(
      "Delete all data successfully",
    ),
    "toast_failure_content": MessageLookupByLibrary.simpleMessage(
      "Something went wrong, please try again",
    ),
    "toast_failure_title": MessageLookupByLibrary.simpleMessage("Failure"),
    "toast_recoverDbSuccess": MessageLookupByLibrary.simpleMessage(
      "Recover all data successfully",
    ),
    "toast_reportExportedSuccess": MessageLookupByLibrary.simpleMessage(
      "Your report exported successfully",
    ),
    "toast_success_title": MessageLookupByLibrary.simpleMessage("Successful"),
    "tooltip_addProject": MessageLookupByLibrary.simpleMessage("Add Project"),
    "tooltip_addTimeEntry": MessageLookupByLibrary.simpleMessage(
      "Add Time Entry",
    ),
    "validator_enterProjectName": MessageLookupByLibrary.simpleMessage(
      "Please enter a project name",
    ),
    "validator_required": MessageLookupByLibrary.simpleMessage("Required"),
    "validator_selectEndDate": MessageLookupByLibrary.simpleMessage(
      "Please select an end date",
    ),
    "validator_selectStartDate": MessageLookupByLibrary.simpleMessage(
      "Please select a start date",
    ),
    "weekday_friday": MessageLookupByLibrary.simpleMessage("Friday"),
    "weekday_friday_code": MessageLookupByLibrary.simpleMessage("Fr"),
    "weekday_monday": MessageLookupByLibrary.simpleMessage("Monday"),
    "weekday_monday_code": MessageLookupByLibrary.simpleMessage("Mo"),
    "weekday_saturday": MessageLookupByLibrary.simpleMessage("Saturday"),
    "weekday_saturday_code": MessageLookupByLibrary.simpleMessage("Sa"),
    "weekday_sunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "weekday_sunday_code": MessageLookupByLibrary.simpleMessage("Su"),
    "weekday_thursday": MessageLookupByLibrary.simpleMessage("Thursday"),
    "weekday_thursday_code": MessageLookupByLibrary.simpleMessage("Th"),
    "weekday_tuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
    "weekday_tuesday_code": MessageLookupByLibrary.simpleMessage("Tu"),
    "weekday_wednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
    "weekday_wednesday_code": MessageLookupByLibrary.simpleMessage("We"),
  };
}
