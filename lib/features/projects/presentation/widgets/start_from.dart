import 'package:flutter/material.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';

class StartFrom extends StatelessWidget {
  final Project project;
  const StartFrom({required this.project, super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Start from: ',
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.primary.withAlpha(150),
            ),
          ),
          if (project.startDate == null)
            TextSpan(
              text: '-',
              style: TextStyle(
                fontSize: 12,
                color: context.colorScheme.primary.withAlpha(150),
              ),
            )
          else
            TextSpan(text: project.startDate.yearMonthDayShort),
        ],
      ),
    );
  }
}
