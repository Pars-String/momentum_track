import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/features/calendar/presentation/bloc/calendar_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime now = DateHelper.today();
  @override
  void initState() {
    super.initState();

    context.read<CalendarBloc>().add(InitThisMonth());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalDateCubit, GlobalDateState>(
      listenWhen: (p, c) => p.dateListStatus != c.dateListStatus,
      listener: (context, state) {
        if (state.dateListStatus == DateListStatus.success) {
          context.read<CalendarBloc>().add(
            InitThisMonth(date: state.thisMonthDates.first),
          );
        }
      },
      builder: (context, state) {
        final List<DateTime> thisMonthDates = state.thisMonthDates;

        return CustomScrollView(
          slivers: [
            SliverAppBar(title: AppChangeDate(state), pinned: true),

            SliverGap(25),

            BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state.overviewStatus == CalendarStatus.loading ||
                    state.overviewStatus == CalendarStatus.initial) {
                  return SliverToBoxAdapter(
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state.overviewStatus == CalendarStatus.failure) {
                  return SliverToBoxAdapter(
                    child: const Center(child: Text('Failed to load overview')),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  sliver: SliverGrid.builder(
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
                            pathParameters: {
                              AppArguments.selectedDate: date.toIso8601String(),
                            },
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: now == date
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
                                    color: now == date
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
                                    color: now == date
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer
                                        : Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                  ),
                                ),
                                if (DateHelper.isToday(date))
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Theme.of(
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
