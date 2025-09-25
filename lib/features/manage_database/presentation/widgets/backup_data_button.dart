import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/features/manage_database/presentation/widgets/backup_data_dialog_box.dart';

class BackupDataButton extends StatelessWidget {
  const BackupDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return BackupDataDialogBox();
          },
        );
      },
      title: 'Create Backup',
      icon: HugeIcons.strokeRoundedDatabaseExport,
    );
  }
}
