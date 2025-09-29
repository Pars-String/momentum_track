import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';

class AddNewEventButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const AddNewEventButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: S.current.tooltip_addTimeEntry,
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedTaskAdd01,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
