import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class DeleteEventButton extends StatelessWidget {
  final VoidCallback? onPressedDelete;
  const DeleteEventButton({super.key, required this.onPressedDelete});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
        showDialog(
          context: context,
          builder: (innerContext) {
            return AlertDialog(
              title: Text('Delete Time Entry'),
              content: Text('Are you sure you want to delete this time entry?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => innerContext.pop(),
                ),
                TextButton(
                  onPressed: onPressedDelete == null
                      ? null
                      : () {
                          innerContext.pop();
                          onPressedDelete?.call();
                        },
                  child: Text('Delete'),
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
