import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/extensions/duration_extension.dart';

class TotalDuration extends StatelessWidget {
  final bool isCalculating;
  final bool hasError;
  final Duration? duration;
  const TotalDuration({
    super.key,
    required this.isCalculating,
    required this.hasError,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalDateCubit, GlobalDateState>(
      builder: (context, state) {
        DateTime? selectedDate;
        if (state.dateListStatus == DateListStatus.success) {
          selectedDate = state.thisMonthDates.first;
        }

        return Text.rich(
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
              else if (hasError)
                TextSpan(
                  text: 'Error calculating duration',
                  style: TextStyle(color: context.colorScheme.error),
                )
              else ...[
                TextSpan(text: duration.inHourAndMinutes),
                if (selectedDate != null)
                  TextSpan(
                    text: ' on ${selectedDate.shortMonthTitle}',
                    style: TextStyle(
                      color: context.colorScheme.primary.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
