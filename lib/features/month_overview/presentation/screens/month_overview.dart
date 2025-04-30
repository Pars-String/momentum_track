import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/features/month_overview/presentation/bloc/overview_bloc.dart';

class MonthOverviewScreen extends StatefulWidget {
  const MonthOverviewScreen({super.key});

  @override
  State<MonthOverviewScreen> createState() => _MonthOverviewScreenState();
}

class _MonthOverviewScreenState extends State<MonthOverviewScreen> {
  final DateTime now = CalculatingHelper.today();
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

        return Column(
          children: [
            AppChangeDate(state),

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

                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisExtent: 75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: thisMonthDates.length,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                              now == date
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: .8,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('EEEE').format(date),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      now == date
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                ),
                              ),
                              Text(
                                '${date.day < 10 ? "0${date.day}" : date.day}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      now == date
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                ),
                              ),
                              if (CalculatingHelper.today() == date)
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
