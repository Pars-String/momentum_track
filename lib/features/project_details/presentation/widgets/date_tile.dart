import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';

class DateTile extends StatelessWidget {
  const DateTile({super.key, required this.date, required this.selectedDate});

  final DateTime date;
  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              date == CalculatingHelper.today()
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
          width: 2,
        ),
        color:
            selectedDate == date
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '${date.day < 10 ? "0${date.day}" : date.day} ${DateFormat('MMM').format(date)}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),

            Text(
              DateFormat('EEE').format(date),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
