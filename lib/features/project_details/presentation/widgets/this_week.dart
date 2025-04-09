import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/date_tile.dart';

class ThisWeek extends StatelessWidget {
  final int projectID;
  const ThisWeek(this.projectID, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      buildWhen:
          (p, c) =>
              p.detailsDateStatus != c.detailsDateStatus ||
              p.selectedDate != c.selectedDate,
      builder: (context, state) {
        final List<DateTime> dateList = [];

        if (state.detailsDateStatus is DetailsDateSuccess) {
          dateList.addAll(
            (state.detailsDateStatus as DetailsDateSuccess).dateList,
          );
        }
        if (state.detailsDateStatus is DetailsDateFailure) {
          return const Text('Error loading date list');
        }
        if (state.detailsDateStatus is DetailsDateLoading ||
            state.detailsDateStatus is DetailsDateInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    dateList.map((e) {
                      return DateTile(
                        selectedDate: state.selectedDate,
                        projectID: projectID,
                        date: e,
                      );
                    }).toList(),
              ),
              Row(
                children: [
                  Gap(8),
                  TextButton(
                    onPressed: () {
                      final DateTime date = dateList.first.subtract(
                        Duration(days: 4),
                      );

                      context.read<DetailsBloc>().add(InitDateList(date: date));
                      context.read<DetailsBloc>().add(
                        SelectNewDate(date: date, projectID: projectID),
                      );
                    },
                    child: Text('Previous Week'),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      final DateTime date = dateList.last.add(
                        Duration(days: 4),
                      );

                      context.read<DetailsBloc>().add(InitDateList(date: date));
                      context.read<DetailsBloc>().add(
                        SelectNewDate(date: date, projectID: projectID),
                      );
                    },
                    child: Text('Next Week'),
                  ),
                  Gap(12),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
