import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';

class AppChangeDate extends StatelessWidget {
  final GlobalDateState state;
  const AppChangeDate(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final String monthTitle =
        '${DateFormat('MMMM').format(state.thisMonthDates.first)} ${state.thisMonthDates.first.year}';

    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setNextMonthDates();
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeftDouble,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Text(monthTitle, style: TextStyle(fontSize: 25)),
        IconButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setPreviousMonthDates();
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedArrowRightDouble,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            context.read<GlobalDateCubit>().setThisMonthDates();
          },
          child: Text('Today'),
        ),
      ],
    );
  }
}
