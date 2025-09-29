import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';

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
              title: Text(S.current.deleteEventButton_deleteDialogBox_title),
              content: Text(
                S.current.deleteEventButton_deleteDialogBox_content,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(S.current.button_cancel),
                  onPressed: () => innerContext.pop(),
                ),
                TextButton(
                  onPressed: onPressedDelete == null
                      ? null
                      : () {
                          innerContext.pop();
                          onPressedDelete?.call();
                        },
                  child: Text(S.current.button_delete),
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
