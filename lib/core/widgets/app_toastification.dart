import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToastification {
  static showInfo(
    BuildContext context, {
    String? title,
    required String description,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,
      title: Text(title ?? 'Successful'),
      description: Text(description, maxLines: 5),
      applyBlurEffect: true,
      alignment: Alignment.bottomLeft,
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
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.minimal,
      title: Text(title ?? 'Failure'),
      description: Text(
        description ?? 'Something went wrong, please try again.',
        maxLines: 5,
      ),
      applyBlurEffect: true,
      alignment: Alignment.bottomLeft,
      autoCloseDuration: const Duration(seconds: 4),
      primaryColor: Color(0xFFFF5C5C),
      backgroundColor: Color(0xFF2C2C2C),
      foregroundColor: Color(0xFFFF5C5C),
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Color(0xFF2C2C2C)),
    );
  }
}
