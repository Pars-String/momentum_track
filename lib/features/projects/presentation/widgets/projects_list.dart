import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/features/projects/presentation/blocs/project_overview_cubit/project_overview_cubit.dart';
import 'package:momentum_track/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/project_tile.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if (state.status == ProjectsStatus.loading ||
            state.status == ProjectsStatus.initial) {
          return SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state.status == ProjectsStatus.failure) {
          return SliverToBoxAdapter(
            child: const Center(child: Text('Failed to load projects')),
          );
        }

        if (state.projects.isEmpty && state.status == ProjectsStatus.success) {
          return SliverToBoxAdapter(
            child: const Center(child: Text('No projects found')),
          );
        }

        return BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
          builder: (context, overviewState) {
            final durations = <int, Duration>{};

            if (state.status == ProjectsStatus.success &&
                overviewState is ProjectOverviewInitial) {
              context.read<ProjectOverviewCubit>().loadProjectDuration(
                state.timeEntries,
              );
            }

            if (overviewState is ProjectOverviewLoaded) {
              durations
                ..clear()
                ..addAll(overviewState.durationsList);

              context.read<GlobalDataFlowCubit>().updateProjectOverviewStatus(
                OverviewStatus.loaded,
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 480,
                  mainAxisExtent: 150,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];

                  return ProjectTile(
                    project: project,
                    duration: durations[project.id],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
