import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/features/manage_database/presentation/widgets/recover_data_dialog_box.dart';

class RecoverDataButton extends StatelessWidget {
  const RecoverDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return RecoverDataDialogBox();
          },
        );
      },
      title: 'Restore Database',
      icon: HugeIcons.strokeRoundedDataRecovery,
    );
  }
}
