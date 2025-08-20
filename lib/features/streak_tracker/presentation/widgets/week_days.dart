import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
          'Mo',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        Gap(28),
        Text(
          'We',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        Gap(30),
        Text(
          'Fr',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
            fontSize: 9.5,
          ),
        ),
        Gap(29),
        Text(
          'Su',
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
