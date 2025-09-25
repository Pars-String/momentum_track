import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_new_project_button.dart';
import 'package:momentum_track/features/projects/presentation/widgets/projects_list.dart';
import 'package:momentum_track/features/streak_tracker/presentation/screens/streak_tracker.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: AppChangeDate(), pinned: true),
          SliverGap(25),
          StreakTracker(),
          SliverGap(12),
          ProjectsList(),
          SliverGap(85),
        ],
      ),
      floatingActionButton: AddNewProjectButton(),
    );
  }
}
