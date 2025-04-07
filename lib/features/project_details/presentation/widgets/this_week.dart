import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                dateList.map((e) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            e == CalculatingHelper.today()
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Colors.transparent,
                        width: 3,
                      ),
                      color:
                          state.selectedDate == e
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                    ),
                    child: InkWell(
                      onTap:
                          state.selectedDate == e
                              ? null
                              : () {
                                context.read<DetailsBloc>().add(
                                  SelectNewDate(date: e, projectID: projectID),
                                );
                              },
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          Text(
                            '${e.day < 10 ? "0${e.day}" : e.day} ${DateFormat('MMM').format(e)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(
                            DateFormat('EEE').format(e),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
