import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/cubit/project_overview_cubit.dart';

class GlobalDataFlowListener {
  static void projectsScreenListener(
    BuildContext context,
    GlobalDataFlowState state,
    DateTime selectedDate,
  ) {
    if (state.projectOverviewStatus == OverviewStatus.needUpdate) {
      context.read<ProjectsBloc>().add(LoadProjects(date: selectedDate));

      context.read<ProjectOverviewCubit>().reset();
    }
  }
}
