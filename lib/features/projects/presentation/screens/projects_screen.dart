import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_modal_view.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    super.initState();

    final DateTime thisMonthDate =
        context.read<GlobalDateCubit>().state.thisMonthDates.first;
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
                        final timeEntries =
                            state.timeEntries
                                .where(
                                  (timeEntry) =>
                                      timeEntry.projectId == project.id,
                                )
                                .toList();
                        final Duration thisMonthDuration =
                            CalculatingHelper.calculateDurationFrom(
                              timeEntries,
                            );

                        return ListTile(
                          title: Text(project.name),
                          trailing: Text(
                            '${thisMonthDuration.inHours}h ${thisMonthDuration.inMinutes.remainder(60)}m',
                          ),
                          subtitle: Text(project.description ?? '-'),
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.projectDetailsScreen,
                              extra: project,
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withAlpha(100),
                            ),
                          ),
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
          AppModalBottomSheet.show(
            context,
            title: 'Add Project',
            children: [AddProjectModalView(innerContext: context)],
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
