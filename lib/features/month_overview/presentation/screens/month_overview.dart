import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/features/month_overview/presentation/bloc/overview_bloc.dart';

class MonthOverviewScreen extends StatelessWidget {
  const MonthOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverviewBloc, OverviewState>(
      builder: (context, state) {
        if (state.overviewStatus == OverviewStatus.initial) {
          context.read<OverviewBloc>().add(InitThisMonth());
        }
        if (state.overviewStatus == OverviewStatus.loading ||
            state.overviewStatus == OverviewStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.overviewStatus == OverviewStatus.failure) {
          return const Center(child: Text('Failed to load overview'));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<OverviewBloc>().add(
                        InitThisMonth(
                          date: state.dates.last.add(Duration(days: 1)),
                        ),
                      );
                    },
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeftDouble,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '${DateFormat('MMMM').format(state.dates.first)} ${state.dates.first.year}',
                    style: TextStyle(fontSize: 25),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<OverviewBloc>().add(
                        InitThisMonth(
                          date: state.dates.first.subtract(Duration(days: 1)),
                        ),
                      );
                    },
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowRightDouble,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      context.read<OverviewBloc>().add(InitThisMonth());
                    },
                    child: Text('Today'),
                  ),
                ],
              ),
              Gap(25),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  mainAxisExtent: 75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.dates.length,
                itemBuilder: (context, index) {
                  final date = state.dates[index];
                  final timeEntries =
                      state.timeEntries
                          .where(
                            (element) =>
                                element.startTime.year == date.year &&
                                element.startTime.month == date.month &&
                                element.startTime.day == date.day,
                          )
                          .toList();

                  return InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            CalculatingHelper.today() == date
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('EEEE').format(date),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${date.day < 10 ? "0${date.day}" : date.day}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (CalculatingHelper.today() == date)
                              Text(
                                'Today',
                                style: const TextStyle(fontSize: 9),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
