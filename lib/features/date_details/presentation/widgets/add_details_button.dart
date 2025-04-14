import 'package:flutter/material.dart';
import 'package:momentum_track/features/date_details/presentation/widgets/add_details_dialog_box.dart';

class AddDetailsButton extends StatelessWidget {
  final DateTime selectedDate;
  final BuildContext innerContext;
  const AddDetailsButton({
    required this.selectedDate,
    required this.innerContext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddDetailsDialogBox(
              innerContext: innerContext,
              selectedDate: selectedDate,
            );
          },
        );
      },
      tooltip: 'Add Time Entry',
      icon: const Icon(Icons.add_circle_rounded),
    );
  }
}
