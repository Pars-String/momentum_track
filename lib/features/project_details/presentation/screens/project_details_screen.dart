import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/add_time_entry_button.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/add_time_entry_modal_view.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/change_date_button.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/this_week.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const String routeName = '/project-details';
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  bool hasInitDate = false;

  @override
  Widget build(BuildContext context) {
    final Project project = GoRouterState.of(context).extra as Project;

    if (!hasInitDate) {
      hasInitDate = true;
      context.read<DetailsBloc>().add(InitDateList());
    }

    return BlocListener<DetailsBloc, DetailsState>(
      listenWhen: (p, c) => p.detailsDateStatus != c.detailsDateStatus,
      listener: (context, state) {
        if (state.detailsDateStatus is DetailsDateSuccess) {
          context.read<DetailsBloc>().add(
            InitTimeEntriesList(projectID: project.id),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          actions: [
            ChangeDateButton(projectID: project.id),
            AddTimeEntryButton(projectID: project.id),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit_note_sharp),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
            child: ThisWeek(project.id),
          ),
        ),
        body: BlocBuilder<DetailsBloc, DetailsState>(
          buildWhen:
              (p, c) => p.projectTimeEntryStatus != c.projectTimeEntryStatus,
          builder: (context, state) {
            final bool isLoading =
                state.projectTimeEntryStatus is TimeEntryLoading ||
                state.projectTimeEntryStatus is TimeEntryInitial;
            final bool isError =
                state.projectTimeEntryStatus is TimeEntryFailure;
            final List<TimeEntry> timeEntries = [];

            if (isLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (isError) {
              return const Center(child: Text('Error loading time entries'));
            }
            if (state.projectTimeEntryStatus is TimeEntrySuccess) {
              timeEntries.addAll(
                (state.projectTimeEntryStatus as TimeEntrySuccess).timeEntries,
              );

              if (timeEntries.isEmpty) {
                return const Center(child: Text('No time entries found'));
              }
            }

            return ListView.separated(
              itemCount: timeEntries.length,
              separatorBuilder:
                  (context, index) =>
                      Divider(color: Theme.of(context).colorScheme.primary),
              itemBuilder: (context, index) {
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

                return ListTile(
                  title: Text(note, style: TextStyle(fontSize: 14)),
                  subtitle: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 3,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Start at  ',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  TextSpan(
                                    text: startTime,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (timeEntry.endTime != null) ...[
                                    TextSpan(
                                      text: '\nEnd at    ',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    TextSpan(
                                      text: '$endTime  ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: DateFormat(
                                        'dd, MMMM',
                                      ).format(timeEntry.endTime!),
                                      style: TextStyle(fontSize: 9),
                                    ),
                                  ],
                                ],
                              ),
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
                  ),

                  onTap: () {
                    AppModalBottomSheet.show(
                      context,
                      title: 'Edit Time Entry Details',
                      children: [
                        AddTimeEntryModalView(
                          innerContext: context,
                          projectID: project.id,
                          timeEntry: timeEntry,
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
