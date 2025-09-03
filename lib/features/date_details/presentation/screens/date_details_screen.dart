import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/parse_data_extension.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/listeners/date_details_listener.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/date_details_app_bar.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/date_details_tile.dart';

class DateDetailsScreen extends StatefulWidget {
  static const String routeName =
      '/date-details/date=:${AppArguments.selectedDate}';

  final String selectedDate;
  const DateDetailsScreen({required this.selectedDate, super.key});

  @override
  State<DateDetailsScreen> createState() => _DateDetailsScreenState();
}

class _DateDetailsScreenState extends State<DateDetailsScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate.parseToDateTime;

    context.read<DateDetailsBloc>().add(
      InitialDetails(selectedDate: selectedDate),
    );

    context.read<GlobalDataFlowCubit>()
      ..resetProjectOverviewStatus()
      ..resetHeatMapStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DateDetailsAppBar(selectedDate: selectedDate),
      body: BlocConsumer<DateDetailsBloc, DateDetailsState>(
        listenWhen: (p, c) => p.dateDetailsStatus != c.dateDetailsStatus,
        listener: DateDetailsListener.call,
        buildWhen: (p, c) => p.dateDetailsStatus != c.dateDetailsStatus,
        builder: (context, state) {
          final List<TimeEntry> timeEntries = [];
          final List<Project> projects = [];

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
