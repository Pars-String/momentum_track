import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/features/manage_database/presentation/widgets/delete_all_data_dialog_box.dart';

class DeleteAllDataButton extends StatelessWidget {
  const DeleteAllDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return DeleteAllDataDialogBox();
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.error,
      title: 'Delete All Data',
      icon: HugeIcons.strokeRoundedFolderRemove,
    );
  }
}
