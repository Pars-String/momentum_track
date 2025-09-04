import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';

class TimeEntryInfo extends StatelessWidget {
  const TimeEntryInfo({super.key, required this.timeEntry});

  final TimeEntry timeEntry;

  String get note {
    return timeEntry.note != null && timeEntry.note?.isNotEmpty == true
        ? timeEntry.note!
        : 'No description';
  }

  String get startTime {
    return '${timeEntry.startTime.hour.toString().padLeft(2, '0')}:${timeEntry.startTime.minute.toString().padLeft(2, '0')}';
  }

  String get endTime {
    return timeEntry.endTime == null
        ? '-'
        : '${timeEntry.endTime?.hour.toString().padLeft(2, '0')}:${timeEntry.endTime?.minute.toString().padLeft(2, '0')}';
  }

  String get duration {
    return timeEntry.endTime == null
        ? 'In progress'
        : '${timeEntry.endTime!.difference(timeEntry.startTime).inHours}h ${timeEntry.endTime!.difference(timeEntry.startTime).inMinutes.remainder(60)}m';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(note, style: TextStyle(fontSize: 14)),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Start at  ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          TextSpan(
                            text: startTime,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer.withAlpha(120),
                            ),
                          ),
                          TextSpan(
                            text: '\nEnd at    ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          TextSpan(
                            text: '$endTime  ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer.withAlpha(120),
                            ),
                          ),
                          if (timeEntry.endTime != null) ...[
                            TextSpan(
                              text: DateFormat(
                                'dd, MMMM',
                              ).format(timeEntry.endTime!),
                              style: TextStyle(
                                fontSize: 9,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer.withAlpha(120),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Text(
                    duration,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
