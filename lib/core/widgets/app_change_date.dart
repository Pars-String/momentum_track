import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';

class AppChangeDate extends StatelessWidget {
  final GlobalDateState state;
  const AppChangeDate(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final String monthTitle =
        '${DateFormat('MMMM').format(state.thisMonthDates.first)} ${state.thisMonthDates.first.year}';
    final DateTime now = CalculatingHelper.today();

    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setNextMonthDates();
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeftDouble,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        Text(monthTitle, style: TextStyle(fontSize: 25)),
        IconButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setPreviousMonthDates();
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowRightDouble,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        Spacer(),
        if (now.year != state.thisMonthDates.first.year ||
            now.month != state.thisMonthDates.first.month)
          TextButton(
            onPressed: () {
              context.read<GlobalDateCubit>().setThisMonthDates();
            },
            child: Text('Current Month'),
          ),
      ],
    );
  }
}
