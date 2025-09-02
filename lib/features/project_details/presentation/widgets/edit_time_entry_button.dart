import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_time_entry_form_with_dialog_box.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/project_details_bloc.dart';

class EditTimeEntryButton extends StatelessWidget {
  const EditTimeEntryButton({super.key, required this.timeEntry});

  final TimeEntry timeEntry;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return AppTimeEntryFormWithDialogBox(
              projects: null,
              selectedDate: timeEntry.startTime,
              timeEntry: timeEntry,
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
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedEdit01,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
