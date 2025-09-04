import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/features/streak_tracker/presentation/cubit/streak_cubit.dart';
import 'package:momentum_track/features/streak_tracker/presentation/widgets/streak_tile.dart';
import 'package:momentum_track/features/streak_tracker/presentation/widgets/week_days.dart';

class StreakTracker extends StatefulWidget {
  const StreakTracker({super.key});

  @override
  State<StreakTracker> createState() => _StreakTrackerState();
}

class _StreakTrackerState extends State<StreakTracker> {
  final Map<int, List<DateTime>> monthDates = {};
  final Map<DateTime, double> dailyDurations = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StreakCubit>().loadStreakCalendar();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalDataFlowCubit, GlobalDataFlowState>(
      listenWhen: (p, c) => p.heatMapStatus != c.heatMapStatus,
      listener: (context, state) {
        if (state.heatMapStatus == HeatMapStatus.needUpdate) {
          context.read<StreakCubit>().loadStreakDurations();
        }
      },
      child: SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        sliver: SliverToBoxAdapter(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  WeekDays(),
                  Gap(3.5),
                  Expanded(
                    child: BlocConsumer<StreakCubit, StreakState>(
                      listenWhen: (p, c) => p.generalStatus != c.generalStatus,
                      listener: (context, state) {
                        if (state.generalStatus == StreakStatus.initial) {
                          context.read<StreakCubit>().loadStreakCalendar();
                        }
                        if (state.calendarStatus is CalendarGenerated &&
                            state.durationStatus is DurationInitial) {
                          final loadedCalendar =
                              state.calendarStatus as CalendarGenerated;
                          monthDates.addAll(loadedCalendar.monthDates);
                          context.read<StreakCubit>().loadStreakDurations();
                        }
                        if (state.durationStatus is DurationFetched &&
                            state.generalStatus ==
                                StreakStatus.completedSecondStep) {
                          final loadedDuration =
                              state.durationStatus as DurationFetched;
                          dailyDurations
                            ..clear()
                            ..addAll(loadedDuration.timelineDurations);
                          context
                              .read<GlobalDataFlowCubit>()
                              .updateHeatMapStatus(HeatMapStatus.loaded);
                        }
                        if (state.generalStatus ==
                            StreakStatus.completedSecondStep) {
                          _scrollToEnd();
                        }
                      },
                      builder: (context, state) {
                        // if (state.calendarStatus is CalendarError ||
                        //     state.durationStatus is DurationError) {
                        //   // final String message =
                        //   //     (state.calendarStatus as CalendarError)
                        //   //         .message;
                        //   return Center(child: Text('Something went wrong'));
                        // }

                        if (state.durationStatus is DurationFetched &&
                            state.calendarStatus is CalendarGenerated) {
                          return Scrollbar(
                            controller: _scrollController,
                            thickness: 3,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: monthDates.entries.map((entry) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // if (entry.value.any(
                                      //   (element) => element.day == 1,
                                      // ))
                                      //   FittedBox(
                                      //     child: Text(
                                      //       entry.value
                                      //           .firstWhere(
                                      //             (element) => element.day == 1,
                                      //           )
                                      //           .monthTitle!,
                                      //     ),
                                      //   )
                                      // else
                                      //   Text(''),
                                      // Gap(8),
                                      if (entry.value.first.weekday != 1)
                                        for (
                                          int i = 0;
                                          i < entry.value.first.weekday - 1;
                                          i++
                                        )
                                          StreakTile(isBlank: true),
                                      ...entry.value.map((date) {
                                        final duration =
                                            dailyDurations[date] ?? 0.0;

                                        return StreakTile(
                                          repeat: duration,
                                          dateTime: date,
                                        );
                                      }),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
