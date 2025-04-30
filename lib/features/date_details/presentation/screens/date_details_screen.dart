import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/add_details_button.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/add_details_dialog_box.dart';

class DateDetailsScreen extends StatelessWidget {
  static const String routeName = '/date-details';
  const DateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime date = GoRouterState.of(context).extra as DateTime;

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat.yMMMMd().format(date)),
        actions: [AddDetailsButton(selectedDate: date, innerContext: context)],
      ),
      body: BlocBuilder<DateDetailsBloc, DateDetailsState>(
        builder: (context, state) {
          final List<TimeEntry> timeEntries = [];
          final List<Project> projects = [];

          if (state.dateDetailsStatus == DateDetailsStatus.initial) {
            context.read<DateDetailsBloc>().add(
              InitialDetails(selectedDate: date),
            );
          }
          if (state.dateDetailsStatus == DateDetailsStatus.loading ||
              state.dateDetailsStatus == DateDetailsStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.dateDetailsStatus == DateDetailsStatus.failure) {
            return const Center(child: Text('Failed to load date details'));
          }
          if (state.dateDetailsStatus == DateDetailsStatus.success) {
            timeEntries.addAll(state.timeEntries);
            projects.addAll(state.projects);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.timeEntries.length,
            separatorBuilder: (context, index) => Gap(8),
            itemBuilder: (context, index) {
              final projectName =
                  projects
                      .firstWhere(
                        (element) => element.id == timeEntries[index].projectId,
                      )
                      .name;
              final TimeEntry timeEntry = timeEntries[index];
              final String note =
                  timeEntry.note != null && timeEntry.note?.isNotEmpty == true
                      ? timeEntry.note!
                      : 'No description';
              final String startTime =
                  '${timeEntry.startTime.hour.toString().padLeft(2, '0')}:${timeEntry.startTime.minute.toString().padLeft(2, '0')}';
              final String endTime =
                  '${timeEntry.endTime?.hour.toString().padLeft(2, '0')}:${timeEntry.endTime?.minute.toString().padLeft(2, '0')}';
              final String duration =
                  timeEntry.endTime == null
                      ? 'In progress'
                      : '${timeEntry.endTime!.difference(timeEntry.startTime).inHours}h ${timeEntry.endTime!.difference(timeEntry.startTime).inMinutes.remainder(60)}m';

              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AddDetailsDialogBox(
                        innerContext: context,
                        selectedDate: date,
                        timeEntry: timeEntry,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
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
                                    color:
                                        Theme.of(
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
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: startTime,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer
                                              .withAlpha(120),
                                        ),
                                      ),
                                      if (timeEntry.endTime != null) ...[
                                        TextSpan(
                                          text: '\nEnd at    ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                Theme.of(
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
                                          ).format(timeEntry.endTime!),
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
                                    color:
                                        Theme.of(
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
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
