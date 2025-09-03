import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/bloc/global_data_flow/listeners/global_data_flow_listener.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/listeners/global_date_listener.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_new_project_button.dart';
import 'package:momentum_track/features/projects/presentation/widgets/projects_list.dart';
import 'package:momentum_track/features/streak_tracker/presentation/screens/streak_tracker.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = context.read<GlobalDateCubit>().state.thisMonthDates.first;
    context.read<ProjectsBloc>().add(LoadProjects(date: selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GlobalDateCubit, GlobalDateState>(
        listenWhen: (p, c) => p.dateListStatus != c.dateListStatus,
        listener: GlobalDateListener.projectsScreenListener,
        builder: (context, state) {
          selectedDate = state.thisMonthDates.first;

          return BlocListener<GlobalDataFlowCubit, GlobalDataFlowState>(
            listenWhen: (p, c) =>
                p.projectOverviewStatus != c.projectOverviewStatus,
            listener: (context, state) {
              GlobalDataFlowListener.projectsScreenListener(
                context,
                state,
                selectedDate,
              );
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(title: AppChangeDate(state), pinned: true),
                SliverGap(25),
                StreakTracker(),
                SliverGap(12),
                ProjectsList(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: AddNewProjectButton(),
    );
  }
}
