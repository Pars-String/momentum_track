import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/app_settings/app_settings_cubit.dart';
import 'package:momentum_track/core/data/enums/language_details.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class AppToastification {
  static showInfo(
    BuildContext context, {
    String? title,
    required String description,
  }) {
    final language = context.read<AppSettingsCubit>().state.languageDetails;

    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(title ?? S.current.toast_success_title),
      description: Text(description, maxLines: 5),
      applyBlurEffect: true,
      alignment: language == LanguageDetails.persian
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      autoCloseDuration: const Duration(seconds: 4),
      primaryColor: Color(0xFFA2E5F5),
      backgroundColor: Color(0xFF2C2C2C),
      foregroundColor: Color(0xFF62C6E6),
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Color(0xFF2C2C2C)),
    );
  }

  static showWarning(
    BuildContext context, {
    String? title,
    String? description,
  }) {
    final language = context.read<AppSettingsCubit>().state.languageDetails;

    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      title: Text(title ?? S.current.toast_failure_title),
      description: Text(
        description ?? S.current.toast_failure_content,
        maxLines: 5,
      ),
      applyBlurEffect: true,
      alignment: language == LanguageDetails.persian
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      autoCloseDuration: const Duration(seconds: 4),
      primaryColor: Color(0xFFFF5C5C),
      backgroundColor: Color(0xFF2C2C2C),
      foregroundColor: Color(0xFFFF5C5C),
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Color(0xFF2C2C2C)),
    );
  }
}
