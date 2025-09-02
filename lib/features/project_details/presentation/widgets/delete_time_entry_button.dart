import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DeleteTimeEntryButton extends StatelessWidget {
  const DeleteTimeEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedDelete03,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
