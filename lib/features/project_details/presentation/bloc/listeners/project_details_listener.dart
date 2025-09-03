import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/project_details_bloc.dart';

class ProjectDetailsListener {
  static void call(BuildContext context, ProjectDetailsState state) {
    if (state.projectDetailsStatus is ProjectDetailsSuccess) {
      final dataFlowState = context.read<GlobalDataFlowCubit>().state;

      if (state.addOrEditTimeEntryStatus == AddOrEditTimeEntryStatus.success &&
          dataFlowState.heatMapStatus == HeatMapStatus.loaded &&
          dataFlowState.projectOverviewStatus == OverviewStatus.loaded) {
        context.read<GlobalDataFlowCubit>()
          ..updateProjectOverviewStatus(OverviewStatus.needUpdate)
          ..updateHeatMapStatus(HeatMapStatus.needUpdate);
      }

      if (state.addOrEditTimeEntryStatus == AddOrEditTimeEntryStatus.success &&
          dataFlowState.heatMapStatus == HeatMapStatus.initial &&
          dataFlowState.projectOverviewStatus == OverviewStatus.initial) {
        context.read<GlobalDataFlowCubit>()
          ..updateProjectOverviewStatus(OverviewStatus.loaded)
          ..updateHeatMapStatus(HeatMapStatus.loaded);
      }
    }
  }
}
