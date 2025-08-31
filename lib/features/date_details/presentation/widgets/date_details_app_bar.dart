import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/add_new_event_button.dart';
import 'package:momentum_track/core/widgets/app_time_entry_form_with_dialog_box.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';

class DateDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DateDetailsAppBar({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(DateFormat.yMMMMd().format(selectedDate)),
      actions: [
        BlocBuilder<DateDetailsBloc, DateDetailsState>(
          builder: (context, state) {
            final List<Project> projects = [];

            if (state.dateDetailsStatus == DateDetailsStatus.success) {
              projects.addAll(state.projects);
            }

            return AddNewEventButton(
              onPressed: projects.isEmpty
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AppTimeEntryFormWithDialogBox(
                            projects: projects,
                            selectedDate: selectedDate,
                            timeEntry: null,
                            onPressedSubmit: (timeEntry) {
                              context.read<DateDetailsBloc>().add(
                                AddNewTimeEntry(timeEntryForm: timeEntry),
                              );
                            },
                          );
                        },
                      );
                    },
            );
          },
        ),
      ],
    );
  }
}
