import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/features/month_overview/presentation/bloc/overview_bloc.dart';

class MonthOverviewScreen extends StatefulWidget {
  const MonthOverviewScreen({super.key});

  @override
  State<MonthOverviewScreen> createState() => _MonthOverviewScreenState();
}

class _MonthOverviewScreenState extends State<MonthOverviewScreen> {
  @override
  void initState() {
    super.initState();

    context.read<OverviewBloc>().add(InitThisMonth());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalDateCubit, GlobalDateState>(
      listenWhen: (p, c) => p.dateListStatus != c.dateListStatus,
      listener: (context, state) {
        if (state.dateListStatus == DateListStatus.success) {
          context.read<OverviewBloc>().add(
            InitThisMonth(date: state.thisMonthDates.first),
          );
        }
      },
      builder: (context, state) {
        final List<DateTime> thisMonthDates = state.thisMonthDates;
        final String monthTitle =
            '${DateFormat('MMMM').format(state.thisMonthDates.first)} ${state.thisMonthDates.first.year}';

        return Column(
          children: [
            Row(
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
            ),

            Gap(25),
            BlocBuilder<OverviewBloc, OverviewState>(
              builder: (context, state) {
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
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          mainAxisExtent: 75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: thisMonthDates.length,
                        itemBuilder: (context, index) {
                          final date = thisMonthDates[index];
                          // final timeEntries =
                          //     state.timeEntries
                          //         .where(
                          //           (element) =>
                          //               element.startTime.year == date.year &&
                          //               element.startTime.month == date.month &&
                          //               element.startTime.day == date.day,
                          //         )
                          //         .toList();

                          return InkWell(
                            onTap: () {
                              context.pushNamed(
                                AppRoutes.dateDetailsScreen,
                                extra: date,
                              );
                            },
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
            ),
          ],
        );
      },
    );
  }
}
