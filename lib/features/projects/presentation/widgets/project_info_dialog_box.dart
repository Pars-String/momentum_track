import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/extensions/duration_extension.dart';

class ProjectInfoDialogBox extends StatefulWidget {
  final Project projectInfo;
  final Duration thisMonthDuration;
  const ProjectInfoDialogBox({
    required this.projectInfo,
    required this.thisMonthDuration,
    super.key,
  });

  @override
  State<ProjectInfoDialogBox> createState() => _ProjectInfoDialogBoxState();
}

class _ProjectInfoDialogBoxState extends State<ProjectInfoDialogBox> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        children: [
          Text(widget.projectInfo.name),
          Spacer(),
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowTurnBackward,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(16),

      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'This Month: ',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.primary.withAlpha(150),
                ),
              ),

              TextSpan(text: widget.thisMonthDuration.inHourAndMinutes),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Start from: ',
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.primary.withAlpha(150),
                ),
              ),
              if (widget.projectInfo.startDate == null)
                TextSpan(
                  text: '-',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.colorScheme.primary.withAlpha(150),
                  ),
                )
              else
                TextSpan(text: widget.projectInfo.startDate.yearMonthDayShort),
            ],
          ),
        ),
        Gap(5),

        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Text(
            widget.projectInfo.description ?? '-',

            style: TextStyle(
              color: context.colorScheme.onSurface.withAlpha(150),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
