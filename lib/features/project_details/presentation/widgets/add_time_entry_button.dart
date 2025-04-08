import 'package:flutter/material.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/project_details/presentation/widgets/add_time_entry_modal_view.dart';

class AddTimeEntryButton extends StatelessWidget {
  final int projectID;
  const AddTimeEntryButton({required this.projectID, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AppModalBottomSheet.show(
          context,
          title: 'Add Time Entry',
          children: [
            AddTimeEntryModalView(innerContext: context, projectID: projectID),
          ],
        );
      },
      tooltip: 'Add Time Entry',
      icon: const Icon(Icons.add_circle_rounded),
    );
  }
}
