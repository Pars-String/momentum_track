import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/features/streak_tracker/presentation/cubit/streak_cubit.dart';
import 'package:momentum_track/features/streak_tracker/presentation/widgets/streak_tile.dart';
import 'package:momentum_track/features/streak_tracker/presentation/widgets/week_days.dart';
import 'package:momentum_track/locator.dart';

class StreakTracker extends StatefulWidget {
  const StreakTracker({super.key});

  @override
  State<StreakTracker> createState() => _StreakTrackerState();
}

class _StreakTrackerState extends State<StreakTracker> {
  final Map<int, List<DateTime>> monthDates = {};
  final ScrollController _scrollController = ScrollController();

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
    return BlocProvider(
      create: (context) => StreakCubit(locator())..loadStreakData(),
      child: Builder(
        builder: (context) {
          return SliverPadding(
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
                        child: BlocBuilder<StreakCubit, StreakState>(
                          builder: (context, state) {
                            if (state is StreakInitial ||
                                state is StreakLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is StreakError) {
                              return Center(child: Text(state.message));
                            } else if (state is StreakLoaded) {
                              monthDates.addAll(state.monthDates);
                              _scrollToEnd();
                            }

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
                                          return InkWell(
                                            onTapDown: (value) {
                                              debugPrint(
                                                'date is ${date.toIso8601String()} and week is ${date.weekday} - ${date.weekdayTitle}',
                                              );
                                            },
                                            child: StreakTile(
                                              // repeat: date.day.toDouble(),
                                              dateTime: date,
                                            ),
                                          );
                                        }),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
