import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/features/projects/presentation/blocs/project_overview_cubit/project_overview_cubit.dart';
import 'package:momentum_track/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';

class GlobalDateListener {
  static void projectsScreenListener(
    BuildContext context,
    GlobalDateState state,
  ) {
    if (state.dateListStatus == DateListStatus.success) {
      context.read<ProjectsBloc>().add(
        LoadProjects(date: state.thisMonthDates.first),
      );
    }

    context.read<ProjectOverviewCubit>().reset();
  }
}
