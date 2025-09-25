import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/features/projects/presentation/blocs/project_overview_cubit/project_overview_cubit.dart';
import 'package:momentum_track/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';

class GlobalDataFlowListener {
  static void projectsScreenListener(
    BuildContext context,
    GlobalDataFlowState state,
    DateTime selectedDate,
  ) {
    if (state.projectOverviewStatus == OverviewStatus.initial) {
      final selectedDate = context
          .read<GlobalDateCubit>()
          .state
          .thisMonthDates
          .first;
      context.read<ProjectsBloc>().add(LoadProjects(date: selectedDate));
    }
    if (state.projectOverviewStatus == OverviewStatus.needUpdate) {
      context.read<ProjectsBloc>().add(LoadProjects(date: selectedDate));

      context.read<ProjectOverviewCubit>().reset();
    }
  }
}
