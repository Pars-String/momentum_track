import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/parse_data_extension.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/listeners/project_details_listener.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/project_details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/project_details_app_bar.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/project_detials_tile.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const String routeName =
      '/project-details/id=:${AppArguments.projectID}';

  final String projectID;
  const ProjectDetailsScreen({super.key, required this.projectID});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();

    final dates = context.read<GlobalDateCubit>().state.thisMonthDates;
    context.read<ProjectDetailsBloc>().add(
      InitProjectDetails(dates, widget.projectID.parseToInt),
    );
    context.read<GlobalDataFlowCubit>()
      ..resetProjectOverviewStatus()
      ..resetHeatMapStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectDetailsAppBar(),
      body: BlocConsumer<ProjectDetailsBloc, ProjectDetailsState>(
        listenWhen: (p, c) =>
            p.addOrEditTimeEntryStatus != c.addOrEditTimeEntryStatus,
        listener: ProjectDetailsListener.call,
        buildWhen: (p, c) =>
            p.projectDetailsStatus != c.projectDetailsStatus ||
            p.addOrEditTimeEntryStatus != c.addOrEditTimeEntryStatus,
        builder: (context, state) {
          final bool isLoading =
              state.projectDetailsStatus is ProjectDetailsInitial ||
              state.projectDetailsStatus is ProjectDetailsLoading ||
              state.addOrEditTimeEntryStatus ==
                  AddOrEditTimeEntryStatus.loading;

          if (isLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (state.timeEntries.isEmpty && !isLoading) {
            return const Center(child: Text('No time entries found'));
          }

          return ListView.separated(
            itemCount: state.timeEntries.length,
            separatorBuilder: (context, index) =>
                Divider(color: Theme.of(context).colorScheme.primary),
            itemBuilder: (context, index) {
              final TimeEntry timeEntry = state.timeEntries[index];

              return ProjectDetailsTile(timeEntry: timeEntry);
            },
          );
        },
      ),
    );
  }
}
