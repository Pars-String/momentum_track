// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fa locale. All the
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
  String get localeName => 'fa';

  static String m0(line) =>
      "${Intl.select(line, {'line1': 'برای بهبود این اپلیکیشن به ما کمک کنید!', 'line2': 'ایده های خودتون، گزارش مشکل و باگ یا درخواست قابلیت جدید رو با ما به اشتراک بذارید.', 'line3': 'شما با ارسال پیام به ایمیل و یا اکانت لینکدین من می توانید درارتباط باشید.', 'other': ''})}";

  static String m1(title) =>
      "${Intl.select(title, {'true': 'ایجاد پروژه جدید', 'false': 'ویرایش پروژه', 'other': ''})}";

  static String m2(projectName) =>
      "آیا واقعاً می‌خواهید پروژه ${projectName} را حذف کنید؟\nاین عملیات قابل بازگشت نیست و تمام ثبت‌های زمانی مرتبط با این پروژه را حذف خواهد کرد.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "button_cancel": MessageLookupByLibrary.simpleMessage("کنسل"),
    "button_changeLanguage": MessageLookupByLibrary.simpleMessage("تغییر زبان"),
    "button_close": MessageLookupByLibrary.simpleMessage("بستن"),
    "button_contactInfo": MessageLookupByLibrary.simpleMessage("اطلاعات تماس"),
    "button_continue": MessageLookupByLibrary.simpleMessage("ادامه"),
    "button_createBackup": MessageLookupByLibrary.simpleMessage(
      "ایجاد پشتیبانی",
    ),
    "button_currentMonth": MessageLookupByLibrary.simpleMessage("ماه جاری"),
    "button_delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "button_deleteData": MessageLookupByLibrary.simpleMessage(
      "حذف تمام اطلاعات",
    ),
    "button_generate": MessageLookupByLibrary.simpleMessage("ایجاد"),
    "button_reportIssue": MessageLookupByLibrary.simpleMessage("گزارش مشکل"),
    "button_restoreDatabase": MessageLookupByLibrary.simpleMessage(
      "بازیابی دیتابیس",
    ),
    "button_saveSelectedMonthAsExcel": MessageLookupByLibrary.simpleMessage(
      "ذخیره اکسل (تاریخ انتخابی)",
    ),
    "button_saveThisMonthAsExcel": MessageLookupByLibrary.simpleMessage(
      "ذخیره اکسل (برای این ماه)",
    ),
    "button_submit": MessageLookupByLibrary.simpleMessage("تایید"),
    "calendarScreen_failure": MessageLookupByLibrary.simpleMessage(
      "مشکل در دریافت اطفاعات تقویم",
    ),
    "calendarScreen_today": MessageLookupByLibrary.simpleMessage("امروز"),
    "calendarType_gregorian": MessageLookupByLibrary.simpleMessage("میلادی"),
    "calendarType_jalali": MessageLookupByLibrary.simpleMessage("شمسی"),
    "common_endAt": MessageLookupByLibrary.simpleMessage("پایان"),
    "common_inProgress": MessageLookupByLibrary.simpleMessage("در حال انجام"),
    "common_noDescription": MessageLookupByLibrary.simpleMessage(
      "بدون توضیحات",
    ),
    "common_pleaseWait": MessageLookupByLibrary.simpleMessage("لطفا صبر کنید"),
    "common_startAt": MessageLookupByLibrary.simpleMessage("شروع"),
    "contactAndSupport_contactDialogBox_contents": m0,
    "dateDetailsScreen_failure": MessageLookupByLibrary.simpleMessage(
      "مشکل در دریافت جزئیات",
    ),
    "deleteEventButton_deleteDialogBox_content":
        MessageLookupByLibrary.simpleMessage(
          "آیا مطمئن هستید که می‌خواهید این ثبت زمان را حذف کنید؟",
        ),
    "deleteEventButton_deleteDialogBox_title":
        MessageLookupByLibrary.simpleMessage("حذف ثبت زمان"),
    "fieldHint_chooseProject": MessageLookupByLibrary.simpleMessage(
      "انتخاب پروژه",
    ),
    "fieldHint_enterDescription": MessageLookupByLibrary.simpleMessage(
      "توضیحات (اختیاری)",
    ),
    "fieldLabel_endAt": MessageLookupByLibrary.simpleMessage("پایان"),
    "fieldLabel_endDate": MessageLookupByLibrary.simpleMessage(
      "انتخاب تاریخ پایان",
    ),
    "fieldLabel_projectName": MessageLookupByLibrary.simpleMessage("نام پروژه"),
    "fieldLabel_startAt": MessageLookupByLibrary.simpleMessage("شروع"),
    "fieldLabel_startDate": MessageLookupByLibrary.simpleMessage(
      "انتخاب تاریخ شروع",
    ),
    "fieldLabel_time": MessageLookupByLibrary.simpleMessage("ساعت"),
    "generateReport_exportDialogBox_title":
        MessageLookupByLibrary.simpleMessage("صدور گزارش"),
    "gregorian_month_april": MessageLookupByLibrary.simpleMessage("آوریل"),
    "gregorian_month_august": MessageLookupByLibrary.simpleMessage("اوت"),
    "gregorian_month_december": MessageLookupByLibrary.simpleMessage("دسامبر"),
    "gregorian_month_february": MessageLookupByLibrary.simpleMessage("فوریه"),
    "gregorian_month_january": MessageLookupByLibrary.simpleMessage("ژانویه"),
    "gregorian_month_july": MessageLookupByLibrary.simpleMessage("ژوئیه"),
    "gregorian_month_june": MessageLookupByLibrary.simpleMessage("ژوئن"),
    "gregorian_month_march": MessageLookupByLibrary.simpleMessage("مارس"),
    "gregorian_month_may": MessageLookupByLibrary.simpleMessage("مه"),
    "gregorian_month_november": MessageLookupByLibrary.simpleMessage("نوامبر"),
    "gregorian_month_october": MessageLookupByLibrary.simpleMessage("اکتبر"),
    "gregorian_month_september": MessageLookupByLibrary.simpleMessage(
      "سپتامبر",
    ),
    "jalali_month_aban": MessageLookupByLibrary.simpleMessage("آبان"),
    "jalali_month_azar": MessageLookupByLibrary.simpleMessage("آذر"),
    "jalali_month_bahman": MessageLookupByLibrary.simpleMessage("بهمن"),
    "jalali_month_dey": MessageLookupByLibrary.simpleMessage("دی"),
    "jalali_month_esfand": MessageLookupByLibrary.simpleMessage("اسفند"),
    "jalali_month_farvardin": MessageLookupByLibrary.simpleMessage("فروردین"),
    "jalali_month_khordad": MessageLookupByLibrary.simpleMessage("خرداد"),
    "jalali_month_mehr": MessageLookupByLibrary.simpleMessage("مهر"),
    "jalali_month_mordad": MessageLookupByLibrary.simpleMessage("مرداد"),
    "jalali_month_ordibehesht": MessageLookupByLibrary.simpleMessage(
      "اردیبهشت",
    ),
    "jalali_month_shahrivar": MessageLookupByLibrary.simpleMessage("شهریور"),
    "jalali_month_tir": MessageLookupByLibrary.simpleMessage("تیر"),
    "manageDatabase_backupDialogBox_chooseDir":
        MessageLookupByLibrary.simpleMessage("لطفاً یک پوشه انتخاب کنید."),
    "manageDatabase_backupDialogBox_title":
        MessageLookupByLibrary.simpleMessage("پشتیبان‌گیری"),
    "manageDatabase_deleteDialogBox_content":
        MessageLookupByLibrary.simpleMessage(
          "آیا واقعاً می‌خواهید تمام داده‌ها را حذف کنید؟",
        ),
    "manageDatabase_deleteDialogBox_title":
        MessageLookupByLibrary.simpleMessage("هشدار"),
    "manageDatabase_recoverDialogBox_content": MessageLookupByLibrary.simpleMessage(
      "این عملیات تمام داده‌های فعلی شما را حذف کرده و آن‌ها را با داده‌های پشتیبان ارائه‌شده توسط شما جایگزین خواهد کرد.",
    ),
    "manageDatabase_recoverDialogBox_title":
        MessageLookupByLibrary.simpleMessage("توجه"),
    "projectDetailsScreen_emptyList": MessageLookupByLibrary.simpleMessage(
      "هیچ ثبت زمانی‌ای یافت نشد",
    ),
    "projectDetailsScreen_fetchData": MessageLookupByLibrary.simpleMessage(
      "در حال دریافت داده‌ها...",
    ),
    "projectsScreen_calculating": MessageLookupByLibrary.simpleMessage(
      "در حال محاسبه",
    ),
    "projectsScreen_calculatingFailure": MessageLookupByLibrary.simpleMessage(
      "خطا در محاسبه مدت زمان",
    ),
    "projectsScreen_emptyList": MessageLookupByLibrary.simpleMessage(
      "هیچ پروژه‌ای یافت نشد",
    ),
    "projectsScreen_failure": MessageLookupByLibrary.simpleMessage(
      "بارگذاری پروژه‌ها با شکست مواجه شد",
    ),
    "projectsScreen_noActivities": MessageLookupByLibrary.simpleMessage(
      "هیچ فعالیتی ثبت نشده است!",
    ),
    "projectsScreen_startFrom": MessageLookupByLibrary.simpleMessage(
      "شروع از ",
    ),
    "projectsScreen_totalDuration": MessageLookupByLibrary.simpleMessage(
      "مدت کل  ",
    ),
    "projects_addOrEditProjectDialogBox_title": m1,
    "projects_deleteProjectDialogBox_content": m2,
    "projects_deleteProjectDialogBox_title":
        MessageLookupByLibrary.simpleMessage("حذف پروژه"),
    "projects_projectInfoDialogBox_createAt":
        MessageLookupByLibrary.simpleMessage("ایجاد شده در "),
    "settingsScreen_appSettings_title": MessageLookupByLibrary.simpleMessage(
      "تنظیمات اپلیکیشن",
    ),
    "settingsScreen_contact_title": MessageLookupByLibrary.simpleMessage(
      "پشتیبانی و راه ارتباطی",
    ),
    "settingsScreen_database_title": MessageLookupByLibrary.simpleMessage(
      "تنظیمات دیتابیس",
    ),
    "settingsScreen_generateReport_title": MessageLookupByLibrary.simpleMessage(
      "تولید گزارش",
    ),
    "sideMenuTitle_calendar": MessageLookupByLibrary.simpleMessage("تقویم"),
    "sideMenuTitle_projects": MessageLookupByLibrary.simpleMessage("پروژه ها"),
    "sideMenuTitle_settings": MessageLookupByLibrary.simpleMessage("تنظیمات"),
    "timeEntryDialogBox_title": MessageLookupByLibrary.simpleMessage(
      "افزودن بازه زمانی",
    ),
    "toast_backupDbSuccess": MessageLookupByLibrary.simpleMessage(
      "پایگاه داده با موفقیت پشتیبان‌گیری شد",
    ),
    "toast_copyEmailToClipboard": MessageLookupByLibrary.simpleMessage(
      "آدرس ایمیل کپی شد",
    ),
    "toast_deleteDbSuccess": MessageLookupByLibrary.simpleMessage(
      "تمام داده‌ها با موفقیت حذف شدند",
    ),
    "toast_failure_content": MessageLookupByLibrary.simpleMessage(
      "مشکلی پیش آمد، لطفاً دوباره تلاش کنید",
    ),
    "toast_failure_title": MessageLookupByLibrary.simpleMessage("ناموفق"),
    "toast_recoverDbSuccess": MessageLookupByLibrary.simpleMessage(
      "تمام داده‌ها با موفقیت بازیابی شدند",
    ),
    "toast_reportExportedSuccess": MessageLookupByLibrary.simpleMessage(
      "گزارش شما با موفقیت صادر شد",
    ),
    "toast_success_title": MessageLookupByLibrary.simpleMessage(
      "با موفقیت انجام شد",
    ),
    "tooltip_addProject": MessageLookupByLibrary.simpleMessage("ایجاد پروژه"),
    "tooltip_addTimeEntry": MessageLookupByLibrary.simpleMessage(
      "افزودن ثبت زمان",
    ),
    "validator_enterProjectName": MessageLookupByLibrary.simpleMessage(
      "لطفا نام پروژه خود را وارد کنید",
    ),
    "validator_required": MessageLookupByLibrary.simpleMessage("ضروری"),
    "validator_selectEndDate": MessageLookupByLibrary.simpleMessage(
      "لطفا تاریخ پایان را انتخاب کنید",
    ),
    "validator_selectStartDate": MessageLookupByLibrary.simpleMessage(
      "لطفا تاریخ شروع را انتخاب کنید",
    ),
    "weekday_friday": MessageLookupByLibrary.simpleMessage("جمعه"),
    "weekday_friday_code": MessageLookupByLibrary.simpleMessage("ج"),
    "weekday_monday": MessageLookupByLibrary.simpleMessage("دوشنبه"),
    "weekday_monday_code": MessageLookupByLibrary.simpleMessage("د"),
    "weekday_saturday": MessageLookupByLibrary.simpleMessage("شنبه"),
    "weekday_saturday_code": MessageLookupByLibrary.simpleMessage("ش"),
    "weekday_sunday": MessageLookupByLibrary.simpleMessage("یک‌شنبه"),
    "weekday_sunday_code": MessageLookupByLibrary.simpleMessage("ی"),
    "weekday_thursday": MessageLookupByLibrary.simpleMessage("پنج‌شنبه"),
    "weekday_thursday_code": MessageLookupByLibrary.simpleMessage("پ"),
    "weekday_tuesday": MessageLookupByLibrary.simpleMessage("سه‌شنبه"),
    "weekday_tuesday_code": MessageLookupByLibrary.simpleMessage("س"),
    "weekday_wednesday": MessageLookupByLibrary.simpleMessage("چهارشنبه"),
    "weekday_wednesday_code": MessageLookupByLibrary.simpleMessage("چ"),
  };
}
