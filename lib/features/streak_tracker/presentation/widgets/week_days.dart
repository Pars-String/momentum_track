import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Gap(5),
        Text(
          S.current.weekday_monday_code,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        Gap(28),
        Text(
          S.current.weekday_wednesday_code,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        Gap(30),
        Text(
          S.current.weekday_friday_code,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        Gap(29),
        Text(
          S.current.weekday_sunday_code,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        // Gap(5),
      ],
    );
  }
}
