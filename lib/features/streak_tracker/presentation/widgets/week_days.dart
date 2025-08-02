import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Mon',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        Gap(24),
        SizedBox(
          height: 20,
          child: Text(
            'Wed',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
        Gap(24),
        SizedBox(
          height: 20,
          child: Text(
            'Fri',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
        Gap(24),
        SizedBox(
          height: 20,
          child: Text(
            'Sun',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
