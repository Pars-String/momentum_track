import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_data_flow_state.dart';

class GlobalDataFlowCubit extends Cubit<GlobalDataFlowState> {
  GlobalDataFlowCubit()
    : super(GlobalDataFlowState(HeatMapStatus.initial, OverviewStatus.initial));

  void resetHeatMapStatus() {
    emit(state.copyWith(heatMapStatus: HeatMapStatus.initial));
  }

  void updateHeatMapStatus(HeatMapStatus status) {
    emit(state.copyWith(heatMapStatus: status));
  }

  void resetProjectOverviewStatus() {
    emit(state.copyWith(projectOverviewStatus: OverviewStatus.initial));
  }

  void updateProjectOverviewStatus(OverviewStatus status) {
    emit(state.copyWith(projectOverviewStatus: status));
  }
}
