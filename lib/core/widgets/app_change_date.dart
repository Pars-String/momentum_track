import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';

class AppChangeDate extends StatelessWidget {
  final GlobalDateState state;
  const AppChangeDate(this.state, {super.key});

  String get selectedMonth => state.thisMonthDates.first.monthTitle!;

  String get nextMonth {
    final selectedDate = state.thisMonthDates.first;
    return selectedDate
        .copyWith(month: selectedDate.month + 1)
        .shortMonthTitle!;
  }

  String get previousMonth {
    final selectedDate = state.thisMonthDates.first;
    return selectedDate
        .copyWith(month: selectedDate.month - 1)
        .shortMonthTitle!;
  }

  @override
  Widget build(BuildContext context) {
    // final DateTime now = DateHelper.today();

    return Row(
      children: [
        TextButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setNextMonthDates();
          },
          child: Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeftDouble,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              Text(nextMonth, style: TextStyle(fontSize: 8)),
            ],
          ),
        ),

        Gap(8),
        SizedBox(
          width: 180,
          child: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: selectedMonth, style: TextStyle(fontSize: 25)),
                  TextSpan(
                    text: '\n${state.thisMonthDates.first.year}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Gap(8),

        TextButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setPreviousMonthDates();
          },
          child: Row(
            children: [
              Text(previousMonth, style: TextStyle(fontSize: 8)),
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRightDouble,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ],
          ),
        ),

        Spacer(),
        BlocBuilder<GlobalDateCubit, GlobalDateState>(
          builder: (context, state) {
            final today = state.today;

            if (today.year != state.thisMonthDates.first.year ||
                today.month != state.thisMonthDates.first.month) {
              return TextButton(
                onPressed: () {
                  context.read<GlobalDateCubit>().setThisMonthDates();
                },
                child: Text('Current Month', style: TextStyle(fontSize: 12)),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
