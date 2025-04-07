import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppModalBottomSheet {
  AppModalBottomSheet._();

  static show(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    double? height,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      title,
                      // style: TextStyle(
                      //   color: AppColors.white,
                      //   fontSize: 20,
                      //   fontWeight: FontWeight.w600,
                      // ),
                    ),
                    const Gap(16),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
