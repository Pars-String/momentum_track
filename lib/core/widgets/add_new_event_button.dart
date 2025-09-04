import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AddNewEventButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const AddNewEventButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: 'Add Time Entry',
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedTaskAdd01,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
