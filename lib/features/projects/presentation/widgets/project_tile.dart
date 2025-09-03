import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/projects/presentation/cubit/project_overview_cubit.dart';
import 'package:momentum_track/features/projects/presentation/widgets/tile_info.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final List<TimeEntry> timeEntries;
  const ProjectTile({
    required this.project,
    required this.timeEntries,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
      builder: (context, state) {
        final isCalculating =
            state is ProjectOverviewLoading || state is ProjectOverviewInitial;
        final calculatingFailed = state is ProjectOverviewFailure;
        Duration duration = Duration.zero;

        if (state is ProjectOverviewInitial) {
          context.read<ProjectOverviewCubit>().loadProjectDuration(
            timeEntries,
            project.id,
          );
        }

        if (state is ProjectOverviewLoaded) {
          duration = state.totalDuration;
          context.read<GlobalDataFlowCubit>().updateProjectOverviewStatus(
            OverviewStatus.loaded,
          );
        }

        return TileInfo(
          project: project,
          duration: duration,
          isCalculating: isCalculating,
          hasError: calculatingFailed,
        );
      },
    );
  }
}
