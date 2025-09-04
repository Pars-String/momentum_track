import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_time_entry_form_with_dialog_box.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';

class DateDetailsTile extends StatefulWidget {
  const DateDetailsTile({super.key, required this.timeEntry});

  final TimeEntry timeEntry;

  @override
  State<DateDetailsTile> createState() => _DateDetailsTileState();
}

class _DateDetailsTileState extends State<DateDetailsTile> {
  late List<Project> projects;
  String get projectName {
    return projects
        .firstWhere((element) => element.id == widget.timeEntry.projectId)
        .name;
  }

  String get duration {
    return widget.timeEntry.endTime == null
        ? 'In progress'
        : '${widget.timeEntry.endTime!.difference(widget.timeEntry.startTime).inHours}h ${widget.timeEntry.endTime!.difference(widget.timeEntry.startTime).inMinutes.remainder(60)}m';
  }

  String get endTime {
    return '${widget.timeEntry.endTime?.hour.toString().padLeft(2, '0')}:${widget.timeEntry.endTime?.minute.toString().padLeft(2, '0')}';
  }

  String get startTime {
    return '${widget.timeEntry.startTime.hour.toString().padLeft(2, '0')}:${widget.timeEntry.startTime.minute.toString().padLeft(2, '0')}';
  }

  String get note {
    return widget.timeEntry.note != null &&
            widget.timeEntry.note?.isNotEmpty == true
        ? widget.timeEntry.note!
        : 'No description';
  }

  @override
  void initState() {
    super.initState();

    projects = context.read<DateDetailsBloc>().state.projects;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return AppTimeEntryFormWithDialogBox(
              projects: projects,
              selectedDate: widget.timeEntry.startTime,
              timeEntry: widget.timeEntry,
              onPressedDelete: () {
                context.read<DateDetailsBloc>().add(
                  DeleteTimeEntry(timeEntryID: widget.timeEntry.id),
                );
              },
              onPressedSubmit: (timeEntry) {
                context.read<DateDetailsBloc>().add(
                  EditTimeEntry(timeEntryForm: timeEntry),
                );
              },
            );
          },
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        projectName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Gap(15),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Start at  ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            TextSpan(
                              text: startTime,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer.withAlpha(120),
                              ),
                            ),
                            if (widget.timeEntry.endTime != null) ...[
                              TextSpan(
                                text: '\nEnd at    ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                              ),
                              TextSpan(
                                text: '$endTime  ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withAlpha(120),
                                ),
                              ),
                              TextSpan(
                                text: DateFormat(
                                  'dd, MMMM',
                                ).format(widget.timeEntry.endTime!),
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withAlpha(120),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        duration,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Expanded(
                  child: Text(
                    note,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
