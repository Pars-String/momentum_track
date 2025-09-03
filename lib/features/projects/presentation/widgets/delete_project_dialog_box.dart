import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';

class DeleteProjectDialogBox extends StatelessWidget {
  const DeleteProjectDialogBox({
    super.key,
    required this.project,
    required this.innerContext,
  });

  final Project project;
  final BuildContext innerContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Project'),
      content: Text(
        'Do you really want to delete ${project.name} project?\n'
        'This action cannot be undone and will delete all time entries '
        'related to this project.',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
            innerContext.read<ProjectsBloc>().add(DeleteProject(project.id));
            innerContext.read<GlobalDataFlowCubit>().updateHeatMapStatus(
              HeatMapStatus.needUpdate,
            );
          },
          child: const Text('Delete'),
        ),
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
      ],
    );
  }
}
