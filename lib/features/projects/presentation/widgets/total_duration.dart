import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/extensions/duration_extension.dart';
import 'package:momentum_track/features/projects/presentation/blocs/project_overview_cubit/project_overview_cubit.dart';

class TotalDuration extends StatelessWidget {
  final Duration? duration;
  const TotalDuration({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectOverviewCubit, ProjectOverviewState>(
      builder: (context, state) {
        final isCalculating =
            state is ProjectOverviewLoading || state is ProjectOverviewInitial;
        final calculatingFailed = state is ProjectOverviewFailure;

        return Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Total duration: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.colorScheme.primary.withAlpha(150),
                    ),
                  ),
                  if (isCalculating)
                    TextSpan(
                      text: 'calculating...',
                      style: TextStyle(
                        color: context.colorScheme.primary.withAlpha(200),
                      ),
                    )
                  else if (calculatingFailed)
                    TextSpan(
                      text: 'Error calculating duration',
                      style: TextStyle(color: context.colorScheme.error),
                    )
                  else
                    TextSpan(text: duration.inHourAndMinutes),
                ],
              ),
            ),
            BlocBuilder<GlobalDateCubit, GlobalDateState>(
              builder: (context, state) {
                DateTime? selectedDate;
                if (state.dateListStatus == DateListStatus.success) {
                  selectedDate = state.thisMonthDates.first;
                }

                if (selectedDate == null &&
                    !isCalculating &&
                    !calculatingFailed) {
                  return const SizedBox.shrink();
                }
                return Text(
                  ' on ${selectedDate.shortMonthTitle}',
                  style: TextStyle(
                    color: context.colorScheme.primary.withAlpha(200),
                    fontSize: 12,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
