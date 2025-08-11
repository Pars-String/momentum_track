import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_dialog_box.dart';
import 'package:momentum_track/features/projects/presentation/widgets/project_tile.dart';
import 'package:momentum_track/features/streak_tracker/presentation/screens/streak_tracker.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    super.initState();

    final DateTime thisMonthDate = context
        .read<GlobalDateCubit>()
        .state
        .thisMonthDates
        .first;
    context.read<ProjectsBloc>().add(LoadProjects(date: thisMonthDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GlobalDateCubit, GlobalDateState>(
        listenWhen: (p, c) => p.dateListStatus != c.dateListStatus,
        listener: (context, state) {
          if (state.dateListStatus == DateListStatus.success) {
            context.read<ProjectsBloc>().add(
              LoadProjects(date: state.thisMonthDates.first),
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(title: AppChangeDate(state), pinned: true),

              SliverGap(25),

              StreakTracker(),

              SliverGap(12),

              BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  if (state.status == ProjectsStatus.loading ||
                      state.status == ProjectsStatus.initial) {
                    return SliverToBoxAdapter(
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.status == ProjectsStatus.failure) {
                    return SliverToBoxAdapter(
                      child: const Center(
                        child: Text('Failed to load projects'),
                      ),
                    );
                  }

                  if (state.projects.isEmpty &&
                      state.status == ProjectsStatus.success) {
                    return SliverToBoxAdapter(
                      child: const Center(child: Text('No projects found')),
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
                          timeEntries: state.timeEntries,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Project',
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddProjectDialogBox(
                innerContext: context,
                projectInfo: null,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
