import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';
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
      title: Text(S.current.projects_deleteProjectDialogBox_title),
      content: Text(
        S.current.projects_deleteProjectDialogBox_content(project.name),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop();
            innerContext.read<ProjectsBloc>().add(DeleteProject(project.id));
            innerContext.read<GlobalDataFlowCubit>()
              ..updateHeatMapStatus(HeatMapStatus.needUpdate)
              ..updateProjectOverviewStatus(OverviewStatus.needUpdate);
          },
          child: Text(S.current.button_delete),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(S.current.button_cancel),
        ),
      ],
    );
  }
}
