import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/listeners/global_date_listener.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';

class AppChangeDate extends StatefulWidget {
  const AppChangeDate({super.key});

  @override
  State<AppChangeDate> createState() => _AppChangeDateState();
}

class _AppChangeDateState extends State<AppChangeDate> {
  late DateTime selectedDate;

  String get selectedMonth => selectedDate.monthTitle!;

  String get nextMonth {
    return selectedDate
        .copyWith(month: selectedDate.month + 1)
        .shortMonthTitle!;
  }

  String get previousMonth {
    return selectedDate
        .copyWith(month: selectedDate.month - 1)
        .shortMonthTitle!;
  }

  @override
  void initState() {
    super.initState();

    selectedDate = context.read<GlobalDateCubit>().state.thisMonthDates.first;
  }

  @override
  Widget build(BuildContext context) {
    // final DateTime now = DateHelper.today();

    return BlocConsumer<GlobalDateCubit, GlobalDateState>(
      listenWhen: (p, c) => p.dateListStatus != c.dateListStatus,
      listener: GlobalDateListener.projectsScreenListener,
      builder: (context, state) {
        final today = state.today;
        selectedDate = state.thisMonthDates.first;

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
                      TextSpan(
                        text: selectedMonth,
                        style: TextStyle(fontSize: 25),
                      ),
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
            if (today.year != state.thisMonthDates.first.year ||
                today.month != state.thisMonthDates.first.month)
              TextButton(
                onPressed: () {
                  context.read<GlobalDateCubit>().setThisMonthDates();
                },
                child: Text('Current Month', style: TextStyle(fontSize: 12)),
              ),
          ],
        );
      },
    );
  }
}
