import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';

class ProjectInfoDialogBox extends StatelessWidget {
  final Project projectInfo;
  const ProjectInfoDialogBox({required this.projectInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(projectInfo.name),
              Spacer(),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedCancel01,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Create at ',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.primary.withAlpha(150),
                  ),
                ),
                if (projectInfo.startDate == null)
                  TextSpan(
                    text: projectInfo.createAt.yearMonthDayShort,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.primary.withAlpha(150),
                    ),
                  )
                else
                  TextSpan(text: projectInfo.startDate.yearMonthDayShort),
              ],
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(18),

      children: [
        Text(
          projectInfo.description ?? '-',

          style: TextStyle(
            color: context.colorScheme.onSurface.withAlpha(150),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
