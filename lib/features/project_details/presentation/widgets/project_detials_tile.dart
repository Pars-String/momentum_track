import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_time_entry_form_with_dialog_box.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/project_details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/date_tile.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/time_entry_info.dart';

class ProjectDetailsTile extends StatelessWidget {
  const ProjectDetailsTile({super.key, required this.timeEntry});

  final TimeEntry timeEntry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return AppTimeEntryFormWithDialogBox(
              projects: null,
              selectedDate: timeEntry.startTime,
              timeEntry: timeEntry,
              onPressedDelete: () {
                context.read<ProjectDetailsBloc>().add(
                  DeleteTimeEntry(timeEntryID: timeEntry.id),
                );
              },
              onPressedSubmit: (timeEntry) {
                context.read<ProjectDetailsBloc>().add(
                  EditTimeEntry(
                    timeEntry: timeEntry.copyWith(projectID: timeEntry.id),
                  ),
                );
              },
            );
          },
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Gap(16),
          DateTile(date: timeEntry.startTime, selectedDate: DateTime.now()),
          Gap(8),
          TimeEntryInfo(timeEntry: timeEntry),
          Gap(16),
        ],
      ),
    );
  }
}
