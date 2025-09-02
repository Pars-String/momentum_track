import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/project_details_bloc.dart';

class DeleteTimeEntryButton extends StatelessWidget {
  final int timeEntryID;
  const DeleteTimeEntryButton({super.key, required this.timeEntryID});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Delete Time Entry'),
              content: Text('Are you sure you want to delete this time entry?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => context.pop(),
                ),
                TextButton(
                  child: Text('Delete'),
                  onPressed: () {
                    context.read<ProjectDetailsBloc>().add(
                      DeleteTimeEntry(timeEntryID: timeEntryID),
                    );
                    context.pop();
                  },
                ),
              ],
            );
          },
        );
      },
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedDelete03,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
