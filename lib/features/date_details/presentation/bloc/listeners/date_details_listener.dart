import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';

class DateDetailsListener {
  static void call(BuildContext context, DateDetailsState state) {
    final dataFlowState = context.read<GlobalDataFlowCubit>().state;

    if (state.dateDetailsStatus == DateDetailsStatus.success &&
        dataFlowState.heatMapStatus == HeatMapStatus.loaded &&
        dataFlowState.projectOverviewStatus == OverviewStatus.loaded) {
      context.read<GlobalDataFlowCubit>()
        ..updateProjectOverviewStatus(OverviewStatus.needUpdate)
        ..updateHeatMapStatus(HeatMapStatus.needUpdate);
    }

    if (state.dateDetailsStatus == DateDetailsStatus.success &&
        dataFlowState.heatMapStatus == HeatMapStatus.initial &&
        dataFlowState.projectOverviewStatus == OverviewStatus.initial) {
      context.read<GlobalDataFlowCubit>()
        ..updateProjectOverviewStatus(OverviewStatus.loaded)
        ..updateHeatMapStatus(HeatMapStatus.loaded);
    }
  }
}
