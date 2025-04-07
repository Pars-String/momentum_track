import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/add_time_entry_modal_view.dart';
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
            IconButton(
              onPressed: () {
                AppModalBottomSheet.show(
                  context,
                  title: 'Add Time Entry',
                  children: [
                    AddTimeEntryModalView(
                      innerContext: context,
                      projectID: project.id,
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.add_circle_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit_note_sharp),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 35),
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
                final String startTime =
                    '${timeEntry.startTime.hour.toString().padLeft(2, '0')}:${timeEntry.startTime.minute.toString().padLeft(2, '0')}';
                final String endTime =
                    '${timeEntry.endTime?.hour.toString().padLeft(2, '0')}:${timeEntry.endTime?.minute.toString().padLeft(2, '0')}';
                final String duration =
                    timeEntry.endTime == null
                        ? 'In progress'
                        : '${timeEntry.endTime!.difference(timeEntry.startTime).inHours}h ${timeEntry.endTime!.difference(timeEntry.startTime).inMinutes.remainder(60)}m';

                return ListTile(
                  title: Text(timeEntry.note ?? ''),
                  subtitle: Text('$startTime - $endTime'),
                  trailing: Text(duration),
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
