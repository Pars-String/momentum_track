import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/main.dart';

class StreakTile extends StatelessWidget {
  final double repeat;
  final bool isBlank;
  final DateTime? dateTime;
  const StreakTile({
    this.repeat = 0,
    this.isBlank = false,
    this.dateTime,
    super.key,
  });

  int get alpha {
    // Ensure hours are clamped between 0–24
    final hoursPassed = repeat.clamp(0, 24);

    // Map hoursPassed (0–24) to an alpha range (e.g., 100–255)
    // The closer to 24, the higher the alpha
    final minAlpha = 100; // when 0 hours passed
    final maxAlpha = 255; // when 24 hours passed

    // Linear interpolation
    return (minAlpha + ((maxAlpha - minAlpha) * (hoursPassed / 24))).round();
  }

  Color? get tileColor {
    final context = navigatorKey.currentState!.context;

    if (isBlank) return null;

    return repeat > 0
        ? Theme.of(context).colorScheme.primaryContainer.withAlpha(alpha)
        : Theme.of(context).scaffoldBackgroundColor;
  }

  String get dayDetails {
    if (dateTime == null) return '';
    DateFormat formatter = DateFormat('dd MMMM, yyyy');
    String formattedDate = formatter.format(dateTime!);
    String dayOfWeek = dateTime!.weekdayTitle!;

    return '$dayOfWeek, $formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Tooltip(
        message: dayDetails,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: tileColor,
          ),
          child: SizedBox.square(
            dimension: 20,
            child: dateTime != DateHelper.today()
                ? null
                : Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FittedBox(
                      child: Text(
                        dateTime!.day.toString(),
                        style: TextStyle(
                          color: repeat > 0
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
