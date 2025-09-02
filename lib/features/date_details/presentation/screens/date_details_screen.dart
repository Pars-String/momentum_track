import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/date_details_app_bar.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/date_details_tile.dart';

class DateDetailsScreen extends StatelessWidget {
  static const String routeName = '/date-details';
  const DateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDateFromCalendar =
        GoRouterState.of(context).extra as DateTime;

    return Scaffold(
      appBar: DateDetailsAppBar(selectedDate: selectedDateFromCalendar),
      body: BlocBuilder<DateDetailsBloc, DateDetailsState>(
        buildWhen: (p, c) => p.dateDetailsStatus != c.dateDetailsStatus,
        builder: (context, state) {
          final List<TimeEntry> timeEntries = [];
          final List<Project> projects = [];

          if (state.dateDetailsStatus == DateDetailsStatus.initial) {
            context.read<DateDetailsBloc>().add(
              InitialDetails(selectedDate: selectedDateFromCalendar),
            );
          }
          if (state.dateDetailsStatus == DateDetailsStatus.loading ||
              state.dateDetailsStatus == DateDetailsStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.dateDetailsStatus == DateDetailsStatus.failure) {
            return const Center(child: Text('Failed to load date details'));
          }
          if (state.dateDetailsStatus == DateDetailsStatus.success) {
            timeEntries.addAll(state.timeEntries);
            projects.addAll(state.projects);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.timeEntries.length,
            separatorBuilder: (context, index) => Gap(8),
            itemBuilder: (context, index) {
              final TimeEntry timeEntry = timeEntries[index];

              return DateDetailsTile(timeEntry: timeEntry);
            },
          );
        },
      ),
    );
  }
}
