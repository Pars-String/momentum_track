import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_modal_view.dart';

class ProjectsScreen extends StatelessWidget {
  static const String routeName = '/';
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state.status == ProjectsStatus.initial) {
                context.read<ProjectsBloc>().add(LoadProjects());
              }

              if (state.status == ProjectsStatus.loading ||
                  state.status == ProjectsStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == ProjectsStatus.failure) {
                return const Center(child: Text('Failed to load projects'));
              }

              if (state.projects.isEmpty &&
                  state.status == ProjectsStatus.success) {
                return const Center(child: Text('No projects found'));
              }
              return ListView.separated(
                itemCount: state.projects.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(color: Theme.of(context).colorScheme.primary),
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.description ?? '-'),
                    onTap: () {
                      context.pushNamed(
                        AppRoutes.projectDetailsScreen,
                        extra: project,
                      );
                    },
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 8),

                child: Text(
                  'DEV 1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
