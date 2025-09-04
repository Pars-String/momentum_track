part of 'global_data_flow_cubit.dart';

enum HeatMapStatus { initial, needUpdate, loaded, failure }

enum OverviewStatus { initial, needUpdate, loaded, failure }

class GlobalDataFlowState extends Equatable {
  final HeatMapStatus heatMapStatus;
  final OverviewStatus projectOverviewStatus;
  const GlobalDataFlowState(this.heatMapStatus, this.projectOverviewStatus);

  @override
  List<Object> get props => [heatMapStatus, projectOverviewStatus];

  GlobalDataFlowState copyWith({
    HeatMapStatus? heatMapStatus,
    OverviewStatus? projectOverviewStatus,
  }) {
    return GlobalDataFlowState(
      heatMapStatus ?? this.heatMapStatus,
      projectOverviewStatus ?? this.projectOverviewStatus,
    );
  }
}
