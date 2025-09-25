import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/extensions/date_reset_extension.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/core/widgets/app_change_date.dart';
import 'package:momentum_track/features/calendar/presentation/bloc/calendar_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime today;
  final List<DateTime> thisMonthDates = [];

  @override
  void initState() {
    super.initState();

    context.read<CalendarBloc>().add(InitThisMonth());
    final dateState = context.read<GlobalDateCubit>().state;
    today = dateState.today.resetTime;
    thisMonthDates.addAll(dateState.thisMonthDates);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GlobalDateCubit, GlobalDateState>(
          listenWhen: (p, c) => p.dateListStatus != c.dateListStatus,
          listener: (context, state) {
            thisMonthDates
              ..clear()
              ..addAll(state.thisMonthDates);

            if (state.dateListStatus == DateListStatus.success) {
              context.read<CalendarBloc>().add(
                InitThisMonth(date: state.thisMonthDates.first),
              );
            }
          },
        ),
        BlocListener<GlobalDateCubit, GlobalDateState>(
          listenWhen: (p, c) => p.today != c.today,
          listener: (context, state) {
            final isToday = DateHelper.isToday(today, state.today);

            if (!isToday) {
              context.read<CalendarBloc>().add(
                InitThisMonth(date: state.thisMonthDates.first),
              );
              today = state.today.resetTime;
            }
          },
        ),
      ],
      child: CustomScrollView(
        slivers: [
          SliverAppBar(title: AppChangeDate(), pinned: true),

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
                    final date = thisMonthDates[index].resetTime;
                    final isToday = DateHelper.isToday(date, today);
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
                          color: isToday
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
                                  color: isToday
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
                                  color: isToday
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer
                                      : Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                ),
                              ),
                              if (isToday)
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
      ),
    );
  }
}
